# Python step by step

## Get started

After cloning this repo, all you need to do is to launch the script `start_workshop.sh`

```bash
./start_workshop.sh
```

This will generate `pictures-analyzer` project in the same directory.

```bash
evolutionary-design-workshop
├── README.md
├── pictures-analyzer
│   ├── Makefile
│   ├── README.md
│   ├── pictures_analyzer
│   │   ├── __init__.py
│   │   ├── __main__.py
│   │   ├── analyzer.py
│   │   ├── safe_box.py
│   │   └── search_engine.py
│   ├── pictures_analyzer_tests
│   │   ├── __init__.py
│   │   └── acceptance
│   │       ├── __init__.py
│   │       ├── pictures
│   │       │   └── top_secret.png
│   │       └── test_analyzer.py
│   ├── requirements_dev.txt
│   └── setup.py
└── start_workshop.sh
```

Move to the generated project, and open it using your favourite IDE.

```bash
cd pictures-analyzer
```

> Something went wrong?
>
>Take a look at "[Need help?](#need-help)" section. You're may be missing some [prerequisites](#prerequisites).

## The starting point

  * Run all the tests

   ```bash
      make tests
   ```

### The Analyzer class

```python

class Analyzer(object):

    def index(self, pictures_directory_path):
        pass
```

* `Analyzer` class is the the entrypoint to ...
* It contains only one public method
* This method is a command (i.e. it doesn't return any value)

* You are not allowed to add any other public methods in this class. (rephrase)
* Start with primitives or simple types, like strings for path variables.

* In `analyzer.py`, you cannot import any external library (i.e., you can only import from `pictures_analyzer` module).

## Libraries
unittest
how to create a mock/stub

## Need help?

### Prerequisites

In this workshop you will need:

* Git (obviously)
* Python 3.5+
* Virtualenv

#### Mac OS

The simplest way to install python3 and virtualenv is to rely on hombrew and pip.

```bash
brew update
brew install python3
pip3 install virtualenv
```

This implies that you have xcode, Homebrew and pip3 installed.
If you miss some of these pre-requisites, you can take a look [here](https://www.digitalocean.com/community/tutorials/how-to-install-python-3-and-set-up-a-local-programming-environment-on-macos)
for a more exhaustive setup instructions.

After installation, the version of python3 on your computer should be higher than 3.5

```bash
python3 --version
```

For the iteration 2, you will also need to install [tesseract](https://github.com/tesseract-ocr):

```bash
brew install tesseract
```

#### Ubuntu

Here are the instructions to install python 3.6 from PPA:

```bash
apt-get install software-properties-common python-software-properties
add-apt-repository ppa:jonathonf/python-3.6
# and press enter to continue.
apt-get update
apt-get install python3.6
pip3 install virtualenv
```

For further details, take a look [here](https://www.rosehosting.com/blog/how-to-install-python-3-6-on-ubuntu-16-04).

For the iteration 2, you will also need to install [tesseract](https://github.com/tesseract-ocr):

```bash
sudo apt-get install tesseract-ocr
```
