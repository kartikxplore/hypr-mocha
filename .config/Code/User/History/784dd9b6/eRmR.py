valid_roles = ("admin", "editor", "viewer")
user_to_check = "maker"

if user_to_check in valid_roles:
    print("Access granted.")
else:
    print("Access denied.")