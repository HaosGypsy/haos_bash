# Make git rememember passwords for a couple hours (120 x 60).
git config --global credential.helper 'cache --timeout=7200'

# Get the fintech repo.
git clone https://gitlab.com/ewha_spring_2016/38046_01_financial_technology.git

# Get some tools.
git clone https://gitlab.com/ewha_spring_2016/z_spring_2016_bash_toolset.git
