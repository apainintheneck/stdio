# Crystal Stdio

A small Crystal library for capturing standard I/O streams.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  stdio:
    github: apainintheneck/stdio
```

## Usage

```crystal
require "stdio"

output, error, input = Stdio.capture do |io|
  STDOUT.puts ":)"
  STDERR.puts ":("
  io.in.puts ":P"
  [io.out.gets, io.err.gets, STDIN.gets]
end

puts output # prints ":)"
puts error  # prints ":("
puts input  # prints ":P"
```

## Decapturing

The `out` and `err` methods return *decapturing* I/Os. The type of the I/O means that the I/O is not capturing the standard I/O any more. In other words, you can not capture the decaptured standard I/O again in the same yielded block after calling `out` or `err`.

```crystal
Stdio.capture do |io|
  STDOUT.puts ":)" # captured
  io.out.gets # decaptured and taken ":)\n"
  STDOUT.puts ":X" # ":X" is printed, not captured
end
```

Why is decapturing needed? Because a process easily hangs up when you send any waiting methods to I/Os that are still capturing the standard I/Os.

To read I/Os keeping capturing and control waiting by yourself, use the `out!` and `err!` methods.

```crystal
Stdio.capture do |io|
  STDOUT.puts ":)"
  io.out!.gets # => ":)\n"
  STDOUT.puts ":X"
  io.out!.gets # => ":X\n"
  io.out!.gets # waits
end
```

## Release Notes

* v1.0.0
  * Support for Crystal 1.x.x
* v0.1.3
  * Capture#out!, Capture#err!
* v0.1.2
  * STDIN

## Contributing

1. Fork it ( https://github.com/apainintheneck/stdio/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mosop](https://github.com/mosop) - original creator, maintainer
- [apainintheneck](https://github.com/apainintheneck) - forker
