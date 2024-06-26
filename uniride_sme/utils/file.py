"""File related functions"""
import base64
import os

from uniride_sme import app
from uniride_sme.utils.exception.exceptions import FileException


def allowed_file(filename, allowed_extensions):
    """Check if file's extension is allowed"""
    extension = filename.rsplit(".", 1)[1].lower()
    if "." not in filename or extension not in allowed_extensions:
        raise FileException("INVALID_FILE_EXTENSION", 422)
    return extension


def save_file(file, directory, allowed_extensions, user_id):
    """Save file"""
    extension = allowed_file(file.filename, allowed_extensions)
    file_name = f"{user_id}.{extension}"
    file.save(os.path.join(directory, file_name))
    return file_name


def delete_file(file, directory):
    """Delete file"""
    os.remove(os.path.join(directory, file))


def get_encoded_file(file_name, file_location):
    """Get encoded file
    :param file_name: file name
    :param file_location: file location,
    either "PFP_UPLOAD_FOLDER"
    or "LICENSE_UPLOAD_FOLDER
    or ID_CARD_UPLOAD_FOLDER
    or SCHOOL_CERTIFICATE_UPLOAD_FOLDER,INSURANCE_UPLOAD_FOLDER "
    :return: encoded file
    """
    if not file_name:
        return ""

    file_path = os.path.join(str(app.config[file_location]), str(file_name))
    if not os.path.isfile(file_path):
        return ""

    file_extension_part = os.path.splitext(file_name)[1].lstrip(".")

    if file_extension_part.lower() == "pdf":
        prefix_url = "data:application/"
    else:
        prefix_url = "data:image/"

    with open(file_path, "rb") as file:
        file_data = base64.b64encode(file.read()).decode("utf-8")

    prefix_url = prefix_url + file_extension_part + ";base64,"
    return prefix_url + file_data
