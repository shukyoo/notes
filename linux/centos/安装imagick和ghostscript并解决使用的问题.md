## 简述
PHP需要安装imagick扩展，用于pdf转图片

## 安装步骤
1. yum安装ImageMagick-devel ghostscript ghostscript-devel ghostscript-fonts cjkuni-fonts-ghostscript
2. 下载，编译，安装PHP imagick扩展
3. 在/usr/bin和/usr/local/bin下都建立或链接gs

## 问题
安装完后出现ImagickException Postscript delegate failed问题

**排查**
直接使用命令跑转pdf

```
convert -density 150 ./test.pdf  -quality 90 output.jpg

出现报错：
Can't find the font file /usr/share/fonts/cjkuni/uming.ttc
```

## 安装字体
之前安装的cjkuni-fonts-ghostscript就是解决中文字体问题的，但是它安装后的目录不对，需要手工再建字体目录
```
cd /usr/share/fonts/
sudo mkdir cjkuni
sudo cp cjkuni-uming/uming.ttc cjkuni/
sudo fc-cache -fv   # 更新字体缓存
```

最终问题解决
