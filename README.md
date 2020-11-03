# CURP Generator

![](https://img.shields.io/badge/build-passing-green)
![](https://img.shields.io/badge/ruby-%3E%3D%202.6.5-blue)
![](https://img.shields.io/github/license/yotepresto-com/curp-generator?color=blue)

Ruby Gem to generate mexican [CURPs](https://en.wikipedia.org/wiki/Unique_Population_Registry_Code).

## Install

Just add the gem to your project:

```sh
gem install curp_generator

# Or using bundler
bundle add curp_generator
```

## Usage

The main class is `CurpGenerator::Curp`. It accepts the following parameters:

| Parameter | Type | Description |
| --------- | ---- | ----------- |
|`first_name`|`String`|The first name of the person.|
|`second_name`|`String`|The middle name of the person.|
|`first_last_name`|`String`|The father's last name of the person.|
|`second_last_name`|`String`|The mother's last name of the person.|
|`gender`|`String`|The gender of the person. Possible values: `male`, `female`,|
|`birth_date`|`DateTime`|The date when the person was born.|
|`birth_state`|`String`|The mexican state where the person was born. Possible values are listed in the [Catalogs module](/lib/catalogs.rb).|

Then, just call the `.generate` method and it will return the CURP for that person.

**Example:**

```rb
require 'curp_generator'

curp = CurpGenerator::Curp.new(
  first_name: 'Maria',
  second_name: 'Alejandra',
  first_last_name: 'De la Rosa',
  second_last_name: 'Ruiz',
  gender: 'female',
  birth_date: DateTime.parse('1989-10-14 06:00:00'),
  birth_state: 'JALISCO'
)

curp.generate # Returns: RORA891014MJCSZL03
```

## License

MIT
