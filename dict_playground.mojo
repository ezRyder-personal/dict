from collections.dict import Dict

# from utils.variant import Variant


trait TPet(Copyable, ImplicitlyDestructible):
    fn start(self, edible: String):
        ...

    fn run(self, edible: String):
        ...


# trait TCat(TPet):
#     fn drink(self, liquid: String): ...


# trait TDog(TPet):
#     fn eat(self, food: String): ...


@fieldwise_init
struct Cat(TPet):
    var name: String

    fn start(self, edible: String):
        self.run(edible)

    fn run(self, liquid: String):
        print(self.name, "drink", liquid)


@fieldwise_init
struct Dog(TPet):
    var name: String

    fn start(self, edible: String):
        self.run(edible)

    fn run(self, food: String):
        print(self.name, "eat", food)


# @value
# struct Pet(TPet):
#     var name: String
#     # var pet: TPet

#     fn start(self, edible: String):
#         self.run(edible)

#     fn run(self, food: String):
#         print(self.name, "eat", food)


@fieldwise_init
struct Pet[S: TPet]:
    var name: String
    var pet: Self.S

    # fn start(self, edible: String):
    #     self.run(edible)

    # fn run(self, food: String):
    #     print(self.name, "eat", food)


comptime cats = "Cats"
comptime dogs = "Dogs"


fn main() raises:
    my_pet = Cat(cats)
    my_pet.start("champagne.")
    my_pet.run("iced tea.")
    ref ref_my_pet = my_pet
    # ref_my_pet.run("iced tea.")

    your_pet = Dog(dogs)
    your_pet.start("blueberries.")
    your_pet.run("treats.")

    # var d = Dict[String, Pet[TPet]]()
    d = Dict[String, Cat]()
    d[cats] = my_pet.copy()
    some_pet = d[cats].copy()
    some_pet.run("water.")
    # d[dogs] = your_pet

    # var pets = DynamicVector[Pet[TPet]]()
    pets = List[Cat]()
    pets.append(my_pet.copy())
    # pets.append(your_pet)
    for pet in pets:
        pet.run("lemonade.")

    # var some_pets = [my_pet, your_pet]
    # some_pets.get[0, Cat]

    # var d = Dict[String, Variant[Cat, Dog]]()
    # d[cats] = my_pet
    # d[dogs] = your_pet

    # var some_pet = d[dogs]
    # some_pet.get[Dog]
    # d[dogs].run("treats.")

    # var d = Dict[String, TPet]()  # Compiler crashes
    # var d = Dict[String, CollectionElement]()  # Compiler crashes

    # var my_cats = Pet(cats)
    # my_cats.set_pet(my_pet)

    # var my_dogs = Pet(dogs)

    # var d = Dict[StringKey, CollectionElement]()  # Compiler crashes
    # var d = Dict[String, TPet]()  # Only works for MyPet, not YourPet
    # var d = Dict[String, Pet[TPet]]()  # Error here

    # d[cats] = my_pet
    # d[dogs] = your_pet

    # print(len(d))  # prints 2
    # print(d[cats].name)  # prints 1
    # d[cats].start("iced tea.")
    # print(d.pop(dogs).name)  # prints 2
    # print(len(d))  # prints 1
