import pandas as pd

df = pd.DataFrame({"patient_id": ["P001", "P002", "P003"],
                    "age": [54, 61, 47]})
print(df.describe())
