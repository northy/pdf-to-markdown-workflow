import fitz, sys, os

pdf_input = sys.argv[1]
output_folder = sys.argv[2]
source_md = sys.argv[3]
output_md = sys.argv[4]
if len(sys.argv)>5 :
    output_folder = sys.argv[5]+output_folder

if not os.path.exists(output_folder):
    os.makedirs(output_folder)

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
        imgs.append(f'![Page {i}]({output} "Page {i}")\n---\n')
        pix.writePNG(output)
    except :
        break
    i+=1

lines = lines[:s+1]+imgs+lines[s+1:]

md = open(output_md,'w',encoding='utf-8')
md.writelines(lines)
md.close()