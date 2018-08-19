# About outside-in TDD and wishful thinking



# Java

## The starting point

### The Analyzer class

language_tabs:
  - java
  - python
```java
public class Analyzer {

    public void index(String picturesDirectoryPath) {
    }
}
```


* `Analyzer` class is the the entrypoint to ...
* It contains only one public method
* This method is a command (i.e. it doesn't return any value)

* You are not allowed to add any other public methods in this class. (rephrase)
* Start with primitives or simple types, like strings for path variables.

### A failing acceptance test

`IndexPictureContentFeature`

```java
    @Test
    void should_use_search_engine_to_index_analyzed_picture_content() {
        // Given
        given(safeBox.upload(PATH_TO_A_PICTURE_FILE)).willReturn(PUBLISHED_PICTURE_URL);

        // When
        analyzer.index(PICTURES_DIRECTORY_PATH);

        // Then
        PictureContent analyzedPictureContent = new PictureContent(PICTURE_FILE_NAME, PUBLISHED_PICTURE_URL, TEXT_IN_PICTURE);
        then(searchEngine).should().index(analyzedPictureContent);
    }
```

* In this test, only external systems `safeBox` and `searchEngine` can be substituted by mocks.
* Our assertion (acceptance criteria) is a side effect is happened. the search engine is c

* Focus on the happy path to achieve. Don't worry about what may go wrong. In this case, just throw a runtime exception (`throw new UnsupportedOperationException()`) for instance.

The test is failing for the good reason ?

### (the inner loop) Unit test

Let's create a first unit test for the analyzer class.

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


Did you finish all unit tests for Analyzer class ?
Run the acceptance test, it will point the next 


Design is about tradeoffs

Interfaces

Same level of abstraction

You cannot test what you don't control

Design when you take decisions that does not change the test color.