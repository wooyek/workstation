echo "----> gitlab-runner"
echo "----> https://docs.gitlab.com/runner/install/linux-repository.html#installing-the-runner"

curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get update
sudo apt-get install gitlab-runner

