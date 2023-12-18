import pandas as pd
from tqdm import tqdm

train_df = pd.read_csv("hindi_all_train.tsv",sep="\t", header=None, encoding = 'utf-8')
dev_df = pd.read_csv("hindi_kb_slh_dev.tsv",sep="\t", header=None, encoding = 'utf-8')
print(train_df)
print(dev_df)

train_df = train_df.sample(frac=1).reset_index(drop=True)
print(train_df)

total_len = len(train_df)+len(dev_df)

print(total_len)

dev_len = total_len//100
print(dev_len)

train_len = len(train_df) - dev_len + len(dev_df)
new_dev_len = len(train_df) - train_len

new_train_df = train_df.head(train_len)
new_dev_df = train_df.tail(new_dev_len)

dev_df_final = pd.concat([dev_df, new_dev_df], ignore_index=True)
print(new_train_df)
print(dev_df_final)

print(len(new_train_df)+len(dev_df_final))

path = "/nlsasfs/home/nltm-st/akankss/thish/datasets/"

new_train_df.to_csv("hindi_all_train_final.tsv", sep='\t', header=False, index=False)
dev_df_final.to_csv("hindi_all_dev_final.tsv", sep='\t', header=False, index=False)
