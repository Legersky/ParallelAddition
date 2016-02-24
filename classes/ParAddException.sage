class ExceptionParAdd(Exception):
    def __repr__(self):
        return 'Instance of ParAddException'

class ValueErrorParAdd(ExceptionParAdd):
    pass

class RuntimeErrorParAdd(ExceptionParAdd):
    pass

class TypeErrorParAdd(ExceptionParAdd):
    pass