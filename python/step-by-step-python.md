# Step by step instructions for python

## Get started

After cloning this repo, all you need to do is to launch the script `start_workshop.sh`:

```bash
./start_workshop.sh
```

This will generate `pictures-analyzer` project in the same directory:

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

Move to the generated project, and open it using your favorite IDE.

```bash
cd pictures-analyzer
```

> Something went wrong?
>
>Take a look at "[Need help?](#need-help)" section. You're may be missing some [prerequisites](#prerequisites).

## The starting point

### Analyzer class

```python

class Analyzer(object):

    def index(self, pictures_directory_path) -> None:
        pass
```

Your starting point is the `Analyzer` class.

It contains only one public method `index`. It's a **command** _(i.e., it doesn't return any value)_ that takes `pictures_directory_path` as unique parameter.

### Outer loop RED: A failing acceptance test

Now, let's take a look at `acceptance.test_analyzer.py`:

```python
    def test_index_should_use_search_engine_to_index_published_image_and_the_text_it_contains(self):
        # Given
        self.safe_box.upload.side_effect = [PUBLISHED_PICTURE_URL]

        # When
        self.analyzer.index(PICTURES_DIRECTORY_PATH)

        # Then
        self.search_engine.index.assert_called_once_with({'name': PICTURE_FILE_NAME,
                                                          'url': PUBLISHED_PICTURE_URL,
                                                          'description': IMAGE_TO_TEXT})
        self.safe_box.upload.assert_called_once_with(PATH_TO_PICTURE_FILE)
```

As `index()` method is a command, the expected behaviour is described through the side effects on external systems.

In this test, external systems `safe_box` and `search_engine` are substituted by mocks in order to control the side effects on them.

* Let's run the tests

```bash
  make tests
```

* Did the test fail for the good reason?

If you got this :point_down: failing message (`AssertionError: Expected 'index' to be called once. Called 0 times.`), the answer is yes!

```bash
F
======================================================================
FAIL: test_index_should_use_search_engine_to_index_published_image_and_the_text_it_contains (acceptance.test_analyzer.TestAnalyzer)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/Users/wasselalazhar/code_repos/pictures-analyzer/pictures_analyzer_tests/acceptance/test_analyzer.py", line 33, in test_index_should_use_search_engine_to_index_published_image_and_the_text_it_contains
    'description': IMAGE_TO_TEXT})
  File "/usr/local/Cellar/python/3.6.4_3/Frameworks/Python.framework/Versions/3.6/lib/python3.6/unittest/mock.py", line 824, in assert_called_once_with
    raise AssertionError(msg)
AssertionError: Expected 'index' to be called once. Called 0 times.

----------------------------------------------------------------------
Ran 1 test in 0.001s

FAILED (failures=1)
```

Indeed, the acceptance test is failing because the search engine did not get called during `Analyze.index` command.

### Inner loop RED: :red_circle: More than a failing Unit test

Now, we can create a first unit test for the analyzer class.

Let's focus on the first requirement about uploading the picture to the safe box, as described in the acceptance test:

```python
        # When
        self.analyzer.index(PICTURES_DIRECTORY_PATH)

        # Then
        self.safe_box.upload.assert_called_once_with(PATH_TO_PICTURE_FILE)
```

The input to our command is a directory path, and the safe_box mock expects a path to a picture file inside this directory:

![pictures directory tree](../illustrations/pictures-directory-python.png)

So, we need, somehow, to list file paths inside a directory.

We can choose tu use a library (built-in or external) for that, or even try to implement it, but we won't.


:relieved:

```python
    def test_index_should_upload_a_file_to_safebox_when_there_is_one_file_in_directory(self):
        # Given
        picture_path = './top_secrets.png'
        self.finder.list_directory.return_value = [picture_path]

        # When
        self.analyzer.index('./pictures')

        # Then
        self.safe_box.upload.assert_called_once_with(picture_path)
        self.finder.list_directory.assert_called_once_with('./pictures')
```

I assume, the analyzer upload a picture file from the picture directory to the safe box.

This first requirement can be expressed through a unit test.

:warning: /!\ Design decision alert /!\

> But actually there is more than one thing to check here.
>
> First, we need the analyzer to look into the files within the pictures directory.
>
> Then, we need to upload them into the safe box.

We can choose to take this requirement as a whole:
Analayzer should 

Or, you may decide to decompose it:

Analyzer -> should fetch files in given pictures directory
Analyzer -> should upload each file to the safe box

![design decision](../illustrations/design-decision-small.png)

![design decision caption](../illustrations/design-decision-caption-small.png)


Did you finish all unit tests for Analyzer class ?
Run the acceptance test, it will point the next 


* Focus on the happy path to achieve. Don't worry about what may go wrong. In this case, just throw a runtime exception (`raise NotImplementedError()`) for instance.
* Start with primitives or simple types, like strings for path variables.
(By the way, in this acceptance test class, only external systems are mocked)


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
