# Executing tests
The tests can be executed by `rake` tasks and other tools, like `rspec`, `chefspec`, `rubocop` and `foodcritic`.

### Rake
All the test strategies and checks can be executed by the rake command.
Please use `rake -T` to see a full list of commands.

### Unit tests
All unit tests are inside the spec folder. You can execute them manually by using RSpec and specifying the test files, like `rspec spec/path/to/my/tests`.

For pure lib tests the projects use solely RSpec, however, for Chef custom resources tests we use a variation of RSpec, the ChefSpec. Both of them work the same way by issuing the `rspec` command.