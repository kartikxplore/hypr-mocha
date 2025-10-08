data = "###REC:12345:REC###"
      
record_id = data[7:12]
last_digit= data[-8]
print(f"{record_id} & {last_digit}")