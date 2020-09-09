import fitz, sys, os

pdf_input = sys.argv[1]
output_folder = sys.argv[2]
source_md = sys.argv[3]
output_md = sys.argv[4]
output_folder_root=output_folder
if len(sys.argv)>5 :
    output_folder_root = sys.argv[5]+output_folder_root

if not os.path.exists(output_folder_root):
    os.makedirs(output_folder_root)

doc = fitz.open(pdf_input)
source = open(source_md,'r',encoding='utf-8')
lines = source.readlines()
source.close()

s = 0
e = 0

for i in range(len(lines)) :
    if lines[i].find("<!-- PDF-TO-MARKDOWN:START -->")!=-1 : s = i
    if lines[i].find("<!-- PDF-TO-MARKDOWN:END -->")!=-1 : e = i
for i in range(e-s-1) :
    del lines[s+1]

i=1
imgs = []
while True :
    try :
        page = doc.loadPage(i-1)
        pix = page.getPixmap()
        output = f"{output_folder}/page{i}.png"
        output_root = f"{output_folder_root}/page{i}.png"
        imgs.append(f'![Page {i}]({output} "Page {i}")\n---\n')
        pix.writePNG(output_root)
    except :
        break
    i+=1

lines = lines[:s+1]+imgs+lines[s+1:]

md = open(output_md,'w',encoding='utf-8')
md.writelines(lines)
md.close()