
# https://docs.microsoft.com/en-us/azure/storage/storage-dotnet-how-to-use-files#mount-the-file-share
$storage_account_name = "vchdsgeneralstorage"
$storage_account_pass = "ZYLpWwtoR9Pn7gftHom21gJXDjhFtnrJqQJsDLMBiv2fOsfefrg86En0T5PkC7RInsqsPDyXKr4l/N542nhYJQ=="

cmdkey /add:vchdsgeneralstorage.file.core.windows.net /user:AZURE\vchdsgeneralstorage /pass:ZYLpWwtoR9Pn7gftHom21gJXDjhFtnrJqQJsDLMBiv2fOsfefrg86En0T5PkC7RInsqsPDyXKr4l/N542nhYJQ==
net use A: \\vchdsgeneralstorage.file.core.windows.net\vchdsfileshare
