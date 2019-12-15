import os

dataset_path = '../Dataset'
all_files = [os.path.join(dp, f) for dp, dn, fn in os.walk(dataset_path) for f in fn if os.path.splitext(f)[1] == '.txt']
print(all_files)
for file_name in all_files:
	fp = open(file_name, 'r').readlines()
	count = 0
	new_file_name = '../NewDataset/' + file_name.split('/')[-1]
	new_file = open(new_file_name, 'w')
	for line in fp:
		count += 1
		final_line = line.strip().replace('   ', '\t').replace('  ', '\t').replace(' ', '\t')
		new_file.write(final_line)
		new_file.write('\n')
	new_file.close()
	print(count)