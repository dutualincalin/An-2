# Laboratories

This repository contains (and is updated each university year):

 * content of each laboratory with detailed explanations, examples and exercises
 * media, such as photos or diagrams, that are used to better portrait examples as well as sources (where need-be - e.g. the UML diagrams can be exported to XML from [draw.io](https://www.draw.io/))
 * skeletons for laboratories which require a starting point

## Repository folder structure

The structure for a current laboratory is as follows:
```
laboratoare
|
|	--->	lab_name  [1]
|		|	--->	skel  [2]
|		|	--->	media [3]
|		|		|	---> image-source [4]
|		|	lab_name  [5]
|	--->	...
|	--->	...
```

The structure for an old or deprecated laboratory is as follows:
```
old
|
|	--->	old_lab_name  [1]
|		|	--->	skel  [2]
|		|	--->	media [3]
|		|		|	---> image-source [4]
|		|	old_lab_name  [5]
|	--->	...
|	--->	...
```

##### [1] - folder with the laboratory name and contents
##### [2] - folder with the skeleton code [if need-be]
##### [3] - folder with images and diagrams [if need-be]
##### [4] - folder with sources of the images/diagrams [if need-be]
##### [5] - file with laboratory details and exercises -- docuwiki code (**must** be the same as the folder name)

## Contributing

If you are interested in fixing issues, detailing laboratory content or just want to lend a helping hand,
please see the document [How to Contribute](CONTRIBUTING.md), which covers the following:

* [Coding Guidelines](CONTRIBUTING.md#coding-guidelines)
* [Submitting pull requests](CONTRIBUTING.md#pull-requests)

This organization has adopted the [Ethics regulation](http://wiki.cs.pub.ro/_media/studenti/licenta/regulament-comisie-de-etica-upb.pdf) and the [Code of Conduct for Students from the Faculty of Automation and Computers](http://wiki.cs.pub.ro/_media/studenti/licenta/cod-conduita-studenti-acs-.pdf). Failure to comply with or violate the rules set out in any of these documents will result in the sanctions imposed by UPB's internal regulations, such as reprimand, written warning, or expulsion from the University POLITEHNICA of Bucharest.

## Feedback

* Ask a question on [the Moodle instance of our university](http://cs.curs.pub.ro/).
* Request a new feature on [GitHub](CONTRIBUTING.md).
* File a bug in [GitHub Issues](https://github.com/oop-pub/laboratoare/issues).

## Related repositories

* [Homeworks](https://github.com/oop-pub/teme) -- content related to assignmnets
* [Wiki](https://github.com/oop-pub/wiki) - content from the [docuwiki instance](http://elf.cs.pub.ro/poo/)

## License

Licensed under the [MIT](LICENSE) License.

