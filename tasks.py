import shutil
from pathlib import Path

from RPA.PDF import PDF
from RPA.Robocorp.utils import get_output_dir
from robocorp import excel
from robocorp.tasks import task


OUTPUT_DIR = Path(get_output_dir())
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
EXCEL_FILE = Path("devdata") / "Data.xlsx"
PDF_TEMPLATE_FILE = Path("devdata") / "invite.template"
PDFS_DIR = OUTPUT_DIR / "temp"
PDFS_DIR.mkdir(parents=True, exist_ok=True)

lib_pdf = PDF()


def get_invitations() -> list[dict]:
    workbook = excel.open_workbook(EXCEL_FILE)
    worksheet = workbook.worksheet(0)
    return worksheet.as_list(header=True)


def generate_pdf(invitation) -> Path:
    pdf_name = f"{invitation['first_name']}_{invitation['last_name']}.pdf"
    pdf_path = PDFS_DIR / pdf_name
    print(f"Generating PDF: {pdf_name}")
    lib_pdf.template_html_to_pdf(PDF_TEMPLATE_FILE, pdf_path, invitation)
    return pdf_path


@task
def create_pdf_invitations():
    invitations = get_invitations()
    pdfs = []
    for invitation in invitations:
        try:
            pdf = generate_pdf(invitation)
        except Exception as exc:
            print(f"Couldn't create PDF invitation due to: {exc}")
        else:
            pdfs.append(pdf)

    archive_path = shutil.make_archive(OUTPUT_DIR / "PDFs", "zip", root_dir=PDFS_DIR)
    print(f"Archive with all the invitations: {archive_path}")
    shutil.rmtree(PDFS_DIR)
