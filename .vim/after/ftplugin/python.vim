" Taken from http://code.lardcave.net/2018/09/09/1/ Thanks!
" Fixed for Python3's importlib
python3 <<EOF
import vim
from importlib.util import find_spec
import os
import glob

def find_virtualenv(virtualenv_names):
    cwd = vim.eval('getcwd()')
    while cwd != '/':
        for virtualenv_name in virtualenv_names:
            venv_path = os.path.join(cwd, virtualenv_name)
            if os.path.exists(venv_path):
                return venv_path

        cwd, _ignored = os.path.split(cwd)

    return os.environ.get('VIRTUAL_ENV')

# If we have a virtualenv, check to see whether it contains pylint and the
# django module. If we don't, just try to import both.  We can't even use
# ale's "ale_virtualenv_dir_names" here, because it's not set yet.

virtualenv_path = find_virtualenv(['virtualenv', 'venv'])  #vim.eval('ale_virtualenv_dir_names')

if virtualenv_path:
    has_pylint_django = glob.glob(os.path.join(virtualenv_path, 'lib/*/site-packages/pylint_django'))
else:
    try:
        find_spec('pylint_django')
        has_pylint_django = True
    except ImportError:
        has_pylint_django = False

if has_pylint_django:
    # No silly 80-char line limit. Sorry pep-8. Also, Django support. Disable 'invalid name', 'missing docstring'
    vim.command("let g:ale_python_pylint_options='--max-line-length=120 --load-plugins pylint_django --disable=invalid-name,missing-docstring'")
else:
    # No silly 80-char line limit. Sorry pep-8. Disable 'invalid name', 'missing docstring'
    vim.command("let g:ale_python_pylint_options='--max-line-length=120 --disable=invalid-name,missing-docstring'")
EOF
