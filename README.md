# Editrix

Editrix is a gem for parsing Healthcare Eligibility Response (271) ASC X12 EDI data into a painless data structure - hash. X12 is a very old and ugly data format that came out more than 60 years, for encoding professional documents such as health and insurance claims, business orders or delivery details, and is still widely used in industries like Healthcare, Finance, Supply Chain, Insurance, Defense etc.

Editrix takes an edi(271 only) input from a developer, like this one...
```text
ISA*00* *00* *ZZ*CMS *ZZ*SUBMITTERID *210315*0734*^*00501*111111111*0*P*|~
GS*HB*CMS*SUBMITTERID*20210315*07340000*1*X*005010X279A1~
ST*271*0001*005010X279A1~
BHT*0022*11*TRANSA*20210315*07342355~
HL*1**20*1~
NM1*PR*2*CMS*****PI*CMS~
HL*2*1*21*1~
NM1*1P*2*IRNAME*****XX*1234567893~
HL*3*2*22*0~
TRN*2*TRACKNUM*ABCDEFGHIJ~
NM1*IL*1*LNAME*FNAME*M***MI*1EG4TE5MK73~
N3*ADDRESSLINE1*ADDRESSLINE2~
N4*CITY*ST*ZIPCODE~
DMG*D8*19400401*F~
...
...
```
into a ruby hash, like this.
```ruby
{"ISA"=>{"ISA01"=>"00", "ISA02"=>" ", "ISA03"=>"00", "ISA04"=>" ", "ISA05"=>"ZZ", "ISA06"=>"CMS ", "ISA07"=>"ZZ", "ISA08"=>"SUBMITTERID ", "ISA09"=>"210315", "ISA10"=>"0734", "ISA11"=>"^", "ISA12"=>"00501", "ISA13"=>"111111111", "ISA14"=>"0", "ISA15"=>"P", "ISA16"=>"|"}, 
 "GS"=>{"GS01"=>"HB", "GS02"=>"CMS", "GS03"=>"SUBMITTERID", "GS04"=>"20210315", "GS05"=>"07340000", "GS06"=>"1", "GS07"=>"X", "GS08"=>"005010X279A1"}, "ST"=>{"ST01"=>"271", "ST02"=>"0001", "ST03"=>"005010X279A1"}, 
 "BHT"=>{"BHT01"=>"0022", "BHT02"=>"11", "BHT03"=>"TRANSA", "BHT04"=>"20210315", "BHT05"=>"07342355"}, "2000A.HL"=>{"HL01"=>"1", "HL02"=>"", "HL03"=>"20", "HL04"=>"1"}, 
 "2000A.NM1"=>{"NM101"=>"PR", "NM102"=>"2", "NM103"=>"CMS", "NM104"=>"", "NM105"=>"", "NM106"=>"", "NM107"=>"", "NM108"=>"PI", "NM109"=>"CMS"}, "2000B.HL"=>{"HL01"=>"2", "HL02"=>"1", "HL03"=>"21", "HL04"=>"1"}} #....
```
or write to files as json, like below, if needed.
```json
{
  "ISA": {
    "ISA01": "00",
    "ISA02": " ",
    "ISA03": "00",
    "ISA04": " ",
    "ISA05": "ZZ",
    "ISA06": "CMS ",
    "ISA07": "ZZ",
    "ISA08": "SUBMITTERID ",
    "ISA09": "210315",
    "ISA10": "0734",
    "ISA11": "^",
    "ISA12": "00501",
    "ISA13": "111111111",
    "ISA14": "0",
    "ISA15": "P",
    "ISA16": "|"
  },
  "GS": {
    "GS01": "HB",
    "GS02": "CMS",
    "GS03": "SUBMITTERID",
    "GS04": "20210315",
    "GS05": "07340000",
    "GS06": "1",
    "GS07": "X",
    "GS08": "005010X279A1"
  },
  "ST": {
    "ST01": "271",
    "ST02": "0001",
    "ST03": "005010X279A1"
  },
  "BHT": {
    "BHT01": "0022",
    "BHT02": "11",
    "BHT03": "TRANSA",
    "BHT04": "20210315",
    "BHT05": "07342355"
  },
  "2000A.HL": {
    "HL01": "1",
    "HL02": "",
    "HL03": "20",
    "HL04": "1"
  },
  "2000A.NM1": {
    "NM101": "PR",
    "NM102": "2",
    "NM103": "CMS",
    "NM104": "",
    "NM105": "",
    "NM106": "",
    "NM107": "",
    "NM108": "PI",
    "NM109": "CMS"
  },
  "2000B.HL": {
    "HL01": "2",
    "HL02": "1",
    "HL03": "21",
    "HL04": "1"
  },
  "2000B.NM1": {
    "NM101": "1P",
    "NM102": "2",
    "NM103": "IRNAME",
    "NM104": "",
    "NM105": "",
    "NM106": "",
    "NM107": "",
    "NM108": "XX",
    "NM109": "1234567893"
  },
  "2000C.HL": {
    "HL01": "3",
    "HL02": "2",
    "HL03": "22",
    "HL04": "0"
  },
  "2000C.TRN1": {
    "TRN01": "2",
    "TRN02": "TRACKNUM",
    "TRN03": "ABCDEFGHIJ"
  },
  "2000C.NM1": {
    "NM101": "IL",
    "NM102": "1",
    "NM103": "LNAME",
    "NM104": "FNAME",
    "NM105": "M",
    "NM106": "",
    "NM107": "",
    "NM108": "MI",
    "NM109": "1EG4TE5MK73"
  },
  "2000C.N3": {
    "N301": "ADDRESSLINE1",
    "N302": "ADDRESSLINE2"
  },
  "2000C.N4": {
    "N401": "CITY",
    "N402": "ST",
    "N403": "ZIPCODE"
  },
  "2000C.DMG": {
    "DMG01": "D8",
    "DMG02": "19400401",
    "DMG03": "F"
  }
} 
```
That's about it.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'editrix'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install editrix

## Usage
```ruby
edi_variable = "--270 edi here--"
parser = Editrix::Parser.new(edi_variable) 
parser.parse              # method that parses the raw 271 edi
puts parser.result        # prints parsed 271 edi in ruby hash

# This gem uses json libraries and therefore can generate pretty json files.
File.open("Parsed_edi.json","w") do |f|
  f.write(parser.prettyResult)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/V4RM4/editrix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/editrix/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Editrix project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/editrix/blob/master/CODE_OF_CONDUCT.md).
