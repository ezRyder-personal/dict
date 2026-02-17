trait Talkable:
    # Use type name `S` here to work around a bug
    fn hello[S: Talkable](self, thing: S) -> String:
        ...

    fn get_name(self) -> String:
        ...


@fieldwise_init
struct Person(Talkable):
    var name: String

    fn hello[T: Talkable](self, thing: T) -> String:
        return self.name + " says hello to " + thing.get_name()

    fn get_name(self) -> String:
        return self.name


@fieldwise_init
struct Dog(Talkable):
    var name: String
    var age: Int

    fn hello[T: Talkable](self, thing: T) -> String:
        return self.name + " barks at " + thing.get_name()

    fn get_name(self) -> String:
        return self.name


fn main():
    var s = Person("Jim")
    var d = Dog("Spot", 2)
    print(s.hello(d))
