# Collaborative Study Guide for CS313E

> https://cs313e-utaustin.github.io/study-guide/

## To Edit

For an existing section, edit the corresponding markdown file in `guide/src`.

To add a new section, edit `book.toml` with the name of the new section and
the markdown file to link.

Please use a different branch and open a [Pull Request](https://github.com/cs313e-utaustin/study-guide/pulls).

## Running Locally

For most changes, it shouldn't be necessary to run the book locally. However, if you
would like to, install Rust followig the instructions [here](https://www.rust-lang.org/tools/install).
and run the following command:

```bash
$ cargo install mdbook
$ make local
```

## Automated Deployment

Commits and merged requests to the main branch should automatically update the website.
