import importlib
import csv


def run():
    def clean(string):
        newString = ''
        for c in string:
            if 64 < ord(c) < 123 or c == ' ':
                newString += c
        return newString

    hello_models = importlib.import_module('hello.models')

    with open('test-data/create-instructions.txt') as instructions:
        for entry in instructions:
            file, model_name = entry.rstrip().split(' ')

            constructor = getattr(hello_models, model_name)

            try:
                with open(file) as csvfile:
                    reader = csv.reader(csvfile, delimiter=';')
                    header = next(reader)
                    header = [clean(entry) for entry in header]

                    def kwargs(values):
                        tuple = {}

                        assert len(values) == len(header), [header, file]

                        for attribute_name, attribute_value in zip(header, values):

                            if attribute_name.startswith('ref'):

                                assert len(attribute_name.split(' ')) == 3, [attribute_name, header, file]

                                attrName, refName = attribute_name.split(' ')[1:]

                                refModelClass = getattr(hello_models, refName)
                                refGetter = getattr(getattr(refModelClass, 'objects'), 'get')

                                tuple[attrName] = refGetter(pk=attribute_value)

                            else:
                                tuple[attribute_name] = attribute_value

                        return tuple

                    for data_row in reader:
                        instance = constructor(**kwargs(data_row))
                        getattr(instance, 'save')()
            except Exception:
                print(file)
                print(entry)
                raise Exception
