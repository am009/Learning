import os, sys, subprocess, json, requests

script_path = os.path.dirname(os.path.realpath(__file__))

exec(open(f"{script_path}/config.sh").read())

comment = subprocess.check_output("git log -n 1 --format=oneline".split(' '), encoding='utf-8')

print(f"comment to https://github.com/repos/{OWNER}/{REPO}/issues/{ISSUE_NUMBER}")
print(f"content: {comment}")
yn = input("continue? [y/n]")
if yn == 'y':
    headers = {"Accept": "application/vnd.github+json", "Authorization": f"Bearer {TOKEN}", "X-GitHub-Api-Version": "2022-11-28"}
    r = requests.post(f'https://api.github.com/repos/{OWNER}/{REPO}/issues/{ISSUE_NUMBER}/comments', json={'body': comment}, headers=headers)
    print(r.json())
