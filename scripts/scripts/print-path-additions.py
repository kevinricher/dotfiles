import subprocess
paths = subprocess.check_output("echo $PATH", shell=True, text=True)
list = paths.split(":")
for item in list:
    print("export PATH=$PATH:" + item)
