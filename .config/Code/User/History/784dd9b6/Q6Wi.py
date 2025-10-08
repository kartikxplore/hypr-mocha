# Snippet 1: Using a tuple
a = (1, 2, 3)
print(f"Initial ID of a: {id(a)}")
a = a + (4,) # Note the comma to make it a tuple
print(f"Final ID of a: {id(a)}")

print("-" * 20)

# Snippet 2: Using a dictionary
b = {"name": "PyProdigy"}
print(f"Initial ID of b: {id(b)}")
b["level"] = "Intermediate"
print(f"Final ID of b: {id(b)}")