---
layout: post
title:  "My first homebrew formula"
date:   2017-10-04 00:00:00 -0400
categories: homebrew
---

I recently wrote a small note taking cli tool called [notem](https://github.com/danpaz/notem)
and wanted to distribute it via [Homebrew](https://brew.sh/). There is documentation
on how to do this as well as examples around the internet but I still found it a
bit tricky to figure out how things all work together.

## So you want to brew

Homebrew essentially manages packages in a GitHub repo, and adding a new package
to the registry comes down to making a git branch and pull request to the repo.

You'll need:
- Homebrew installed
- A binary you want to distribute to folks
- A public url to that binary

To get a public url I published my program to a new GitHub repo (danpaz/notem).
Then I gave it a git tag so that GitHub would generate a tagged release
automatically based on that tag.

```sh
git add . && git commit -m "Initial commit"
git tag 0.0.1
git push && git push --tags

```

This results in a tar archive available at https://github.com/danpaz/notem/archive/0.0.1.tar.gz.

## Formulas

Next I had to write a [formula](https://docs.brew.sh/Formula-Cookbook.html), a
ruby script that tells Homebrew how to install the package. The
`brew create <url>` command helps out by creating the boilerplate file with
space for me to define the installation of my binary.

```sh
brew create https://github.com/danpaz/notem/archive/0.0.1.tar.gz
```

This created a file for me at /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/notem.rb.
I deleted the comment blocks and filled in the `install` and `test` function
bodies. Here's what I ended up with:

```ruby
class Notem < Formula
  desc "Super simple note taking system"
  homepage "https://github.com/danpaz/notem"
  url "https://github.com/danpaz/notem/archive/0.0.1.tar.gz"
  sha256 "e9aa372dcce352938d0042b96a782de4dd319a5aceeae74dbfdac1c5ba1084f8"

  def install
    # Add a symlink to my binary.
    bin.install "notem"
  end

  test do
    # Run a command to verify the install. I think this command has to exit with
    # status 0 to pass the test.
    system "#{bin}/notem", "-l"
  end
end
```

For `install`, I added `bin.install "notem"` to add my binary to the user's path.
For `test` I added `system "#{bin}/notem", "-l"` which verifies my binary runs
successfully after install.

I found it useful to refer to other packages' formulas. As mentioned earlier
these are all on GitHub. For example, [here's the tmux formula](https://github.com/Homebrew/homebrew-core/blob/master/Formula/tmux.rb).

To verify I ran

```sh
brew audit --new-formula notem
```

and got this output:

```
notem:
  * GitHub repository not notable enough (<20 forks, <20 watchers and <50 stars)
  * GitHub repository too new (<30 days old)
Error: 2 problems in 1 formula
```

Ouch.

## Tap out

So my hot new program isn't official enough for Homebrew.
Luckily you can still publish your binary as a [tap](https://docs.brew.sh/brew-tap.html),
a third-party repository.

Users can then install with an extra command, like this:

```sh
brew tap danpaz/tap
brew install notem
```

That's good enough for me! Let's set it up.

I created a new repo called danpaz/homebrew-tap, and this repo will house all of
my future brew formulas. In that repo I copied over my `notem` formula from earlier:

```sh
cp /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/notem.rb ./Formula
```

And `git push`ed that to GitHub. That's it! Now `brew tap danpaz/tap` will clone
this repo to the user's Taps and let them install my package with `brew install notem`.

## Helpful links

* https://docs.brew.sh/Formula-Cookbook.html
* https://speakerdeck.com/defeated/homebrew-publish-your-first-formula
* http://kylebebak.github.io/post/distribute-program-via-homebrew

-D
