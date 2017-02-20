# For JUnit output Circle can read

# Also add to mix.exs:
# {:junit_formatter, "~> 1.1", only: :test}

ExUnit.configure formatters: [JUnitFormatter, ExUnit.CLIFormatter]