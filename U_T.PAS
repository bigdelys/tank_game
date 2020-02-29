unit U_T;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons,mmsystem,math;

type
  Tmf = class(TForm)
    im: TImage;
    start: TSpeedButton;
    SpeedButton1: TSpeedButton;
    lab_v: TStaticText;
    lab_c: TStaticText;
    SpeedButton2: TSpeedButton;
    lab_n: TLabel;
    SpeedButton3: TSpeedButton;
    lab_money: TLabel;
    lab_wins: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    procedure startClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  const
//Number=2;
l_pipe=10;
g=50;
r_explode=25;
d_angle=3;

type

khak=record
y:integer;
end;

TTank=class
c{corner}:double;//Integer;
c_c{corner clean}:double;//Integer;
x:Integer;
y:Integer;
shift:Boolean;
v_i{,vx,vy{initial velocity}:Integer;
boodan:boolean;
pic:Tbitmap;
life:integer;
name:shortstring;
//max_v:integer;
money:Integer;
wins:word;
procedure Draw_pipe;
procedure Draw_Body;
procedure Draw_Body_first;
procedure clean_pipe;
procedure Field(x_exp,y_exp,power:integer);
procedure explode;
procedure fall;
procedure change_color;
end;
{
bomber=class
x:Integer;
y:Integer;
shift:Boolean;
khord:Boolean;
pic:Tbitmap;
end;
 }
a_t{array of TTank}=array [1..19] of TTank;
//a_b{array of bomber}=array [1..Number]of bomber;






  var
  mf:Tmf;
  Number: Integer;
  tank:a_t;
implementation

uses U_T2;

{$R *.DFM}



var
//Number:Integer;
counter_level:Integer;
first:boolean;
a,a_khak:array [-1..1000] of khak;
volume:integer;
//tank:a_t;
iw,ih:Integer;
//t:Single;
b:boolean;
k{k is prameter that hold turn of tank}:Integer;
x_break,y_break,frac_seed,blue_max,red_max,tree_height:Integer;
x3:Integer;

{-----------------------}

procedure circle(x,y,r:Integer);
begin
mf.im.Canvas.Ellipse(x-r,y-r,x+r,y+r);
//mf.im.Canvas.Ellipse(100,100,150,150);
end;

{-----------------------}

Function Get_Color (x,y:Integer):Tcolor;
var
 r,g,b:byte;
 p:PByteArray;
begin

if (y>=0) and (y<=ih) and (x>=0) and (x<=iw) then
begin

p:=mf.im.Picture.Bitmap.ScanLine[y];
x3:=x*3;
b:=p[x3];
g:=p[x3+1];
r:=p[x3+2];
result:=rgb(r,g,b);
end
else
result:=-1;

end;

{-----------------------}

Procedure  Put_Color (x,y:Integer;const col:Tcolor);
var
 p:PByteArray;
begin

if (y>=0) and (y<=ih) and (x>0) and (x<=iw) then
begin
p:=mf.im.Picture.Bitmap.ScanLine[y];
x3:=x*3;
p[x3]:=getbvalue(col);
p[x3+1]:=getgvalue(col);;
p[x3+2]:=getrvalue(col);;
end;
end;

{-----------------------}

function d_r{degree to radian}(c:single):Single;
begin
result:=c*pi/180;
end;
{-----------------------}
function bc(a:Double):Single;

begin

bc:=l_pipe*cos(d_r(a));
end;

{-----------------------}

procedure turn;forward;
procedure Show_Border;forward;

procedure init;forward;

function barkhord(p_x,p_y,num:integer):boolean;
var
o,i,min,d,n_tank,j:integer;

begin
result:=false;
for i:=1 to Number do
if (tank[i].x-16<p_x) and (p_x<tank[i].x+tank[i].pic.width-16) and
 (tank[i].y-12<p_y)  and (p_y<tank[i].y+tank[i].pic.width-12{20}) and (num>200) and (tank[i].boodan)
 then
if tank[i].pic.Canvas.Pixels[ p_x-(tank[i].x-16),p_y-(tank[i].y-12)]<>clblack then
begin

result:=true;
tank[i].explode;

end;





 end;
 {------------------------------------------------------------------------------}
function Try_fall(x,y:Integer):boolean ;
var
i:Integer;
q:Integer;
begin
q:=0;
for i:=0 to 31 do
if mf.im.Canvas.Pixels[x-16+i,y+21]=clblack then inc(q);
if q>=10 then result:=true
else result:=false;

end;




 {-----------------------}
function ab(a:Double):Single;
begin
ab:=l_pipe*sin(d_r(a));
end;
{-----------------------}
procedure line(x_1,y_1,x_2,y_2:Integer);
begin
mf.Im.Canvas.MoveTo(x_1,y_1);
mf.Im.Canvas.LineTo(x_2,y_2);

end;

procedure show_all_pipe;
var
i:integer;

begin
for i:=1 to Number do
begin
if tank[i].boodan=true then
 begin
 tank[i].draw_pipe;
 tank[i].Draw_Body;
 end;
end;

end;

{--------------------------------}


procedure Soil_Roll(tx:integer);
var
i:integer;
sabet,x,min:integer;
{-----------------}

procedure part;
var
 i:Integer;
 col:Tcolor;
begin
min:=x-1;
for i:=x-1 to x+1 do
if a_khak[i].y<a_khak[min].y  then
min:=i;

if (random<(abs( (a_khak[min].y-a_khak[x].y)/{10}(1*abs(x-(tx{- r_explode}))+1) )))
and   (a_khak[min].y=a[min].y) and (a_khak[x].y=a[x].y)
 then
begin

col:=get_color(x,ih-a_khak[x].y);
//put_color(x,ih-a_khak[x].y,clblack);

mf.im.Canvas.Pixels[x,ih-a_khak[x].y]:=clblack;

a_khak[x].y:=a_khak[x].y-1;
a_khak[min].y:=a_khak[min].y+1;

//Put_color(min,ih-a_khak[min].y,col){cllime};
mf.im.Canvas.Pixels[min,ih-a_khak[min].y]:=col;


a[min].y:=a_khak[min].y;
a[x].y:=a_khak[x].y;
end;
// mf.im.Repaint;

end;
{-------------------}

begin
for sabet:=1 to 200 do
begin


 for x:=tx+r_explode*2 downto tx-r_explode*2 do
 if (x>0) and (x<iw) then
 begin
 part;
// a_khak[x].y:=a[x].y;
 end;

if sabet mod 10=0 then
begin
mf.im.Canvas.pen.Mode:=pmxor;
show_all_pipe;
mf.im.Repaint;
show_all_pipe;
mf.im.Canvas.pen.Mode:=pmcopy;
end;
 end;
 mf.im.Canvas.pen.Mode:=pmxor;
 end;


{-----------------------}

procedure Make_Fire(xf,xe:Integer);
const
height={10}40;
var
 xc,yc,x,y,f,r,g,b,width:Integer;
 fr:array [0..640,0..height] of integer;
 bol,exist:boolean;
 p:PBytearray;
begin

 width:=xe-xf;


 for x:=xf to xe do
  for y:=0 to a_khak[x].y do
  if mf.im.Canvas.Pixels[x,ih-a_khak[x].y]=clblack then
   begin
   if (a[x].y=a_khak[x].y) then dec(a[x].y);
   dec (a_khak[x].y);
   end;
mf.im.Canvas.Pen.Mode:=pmcopy;

 for x:=0 to width do
  for y:=0 to height do
   fr[x,y]:=0;
{
  for x:=0 to width do
  for y:=0 to 100 do
   fr[x,y]:=rgb(255-y*2-50,0,0);
 }

// mf.im.Canvas.Unlock;
// mf.im.Canvas.ClipRect.Left :=xf;
 //rect(xf,yf,xf+width,yf-height);
exist:=true;
while exist do
begin
 exist:=false;
 bol:=(random<0.9);

 for x:=0 to width do
  fr[x,0]:=255+random(10)*100;

 for x:=1 to width-1 do
  begin
  for y:=1 to height-1 do
   begin
   xc:=x+xf;
   yc:=ih-a[xc].y-y;
   if xc>iw then xc:=iw;
 if
 (a[xc].y<>a_khak[xc].y)
//  ({get_color(xc,yc)}{mf.im.Canvas.Pixels[xc,yc]<>clblack}true)
//    (mf.im.Canvas.Pixels[xc,ih-a[xc].y]=clblack)
     and (yc<ih)

 then
  begin
   exist:=true;
   fr[x,y]:={10-random(21)+}round( (( fr[x-1,y]+fr[x+1,y]+fr[x,y-1]+fr[x,y+1] ) div 4 )*( 1+ (10-random(21))/50 ) );
   f:=fr[x,y];
   b:=0;
   if f<=255 then
   begin
    r:=f;
    g:=0;
   end
    else
    if f<=255*2 then
   begin
    r:=255;
    g:=f-255;
   end
   else
    if f<=255*3 then
   begin
    r:=255;
    g:=255;
    b:=f-255*2;
   end
   else
   begin
    r:=255;
    g:=255;
    b:=255;
   end;


//   if r>255 then r:=255;
 //  if g>r then g:=r;
// if g>255 then r:=255;

if (yc>=0) and (yc<=ih) then
p:=mf.im.Picture.Bitmap.ScanLine[yc];

p[xc*3]:=b;
p[xc*3+1]:=g;
p[xc*3+2]:=r;
//   mf.im.canvas.Pixels[xc,yc]:=rgb(r,g,b);

   end;
  end;

 if a[xc].y<>a_khak[xc].y then
 if bol then
    dec(a[xc].y);

//    for x:=0 to width do

yc:=ih-a[xc].y-height;
if (yc>=0) and (yc<=ih-1) then p:=mf.im.Picture.Bitmap.ScanLine[yc];

p[xc*3]:=0;
p[xc*3+1]:=0;
p[xc*3+2]:=0;

// mf.im.Canvas.Pixels[xc,{yf-}ih-a[xc].y-height]:=clblack;
  end;

//if i mod 2 =0 then
// mf.im.Repaint;

// if i mod 10=0 then
//begin
mf.im.Canvas.pen.Mode:=pmxor;
show_all_pipe;
mf.im.Repaint;
show_all_pipe;
mf.im.Canvas.pen.Mode:=pmcopy;
//end;


end;

for x:=xf to xe do
 a[x].y:=a_khak[x].y;

 for x:=1 to width+1 do
  for y:=1 to height+1 do
   Put_color(x+xf,ih-a[x+xf].y-y,clblack);;

Show_border;

mf.im.Canvas.Pen.Mode:=pmxor;
end;

{--------------------------------}

procedure Make_Fire2(xf,xe:Integer);
const
height=100;
var
 i,xc,yc,x,y,f,r,g,b,width:Integer;
 fr:array [0..640,0..height] of integer;
 bol,exist:boolean;
 p:PBytearray;
begin

 width:=xe-xf;

mf.im.Canvas.Pen.Mode:=pmcopy;

 for x:=0 to width do
  for y:=0 to height do
   fr[x,y]:=0;

  for x:=0 to width do
  for y:=0 to height do
   fr[x,y]:=255*2;


// mf.im.Canvas.Unlock;
// mf.im.Canvas.ClipRect.Left :=xf;
 //rect(xf,yf,xf+width,yf-height);
exist:=true;
//while exist do
for i:=1 to 1000 do
begin
// exist:=false;
// bol:=(random<0.9);

 for x:=0 to width do
  fr[x,0]:=255+random(100)*100;

 for x:=1 to width-1 do
  begin
  for y:=0 to height-1 do
   begin
   xc:=x+xf;
   yc:=ih{-a[xc].y}-iw div 2+100-y;
// if (a[xc].y<>a_khak[xc].y) and (mf.im.canvas.Pixels[xc,yc]<>clblack)
//     and (yc<ih)

// then
  begin
   exist:=true;
   fr[x,y]:={10-random(21)+}round( (( fr[x-1,y]+fr[x+1,y]+fr[x,y-1]+fr[x,y+1] ) div 4 )*( 1+ (10-random(21))/50 ) );
   f:=fr[x,y];
   b:=0;
   if f<=255 then
   begin
    r:=f;
    g:=0;
   end
    else
    if f<=255*2 then
   begin
    r:=255;
    g:=f-255;
   end
   else
    if f<=255*3 then
   begin
    r:=255;
    g:=255;
    b:=f-255*2;
   end
   else
   begin
    r:=255;
    g:=255;
    b:=255;
   end;


//   if r>255 then r:=255;
 //  if g>r then g:=r;
// if g>255 then r:=255;

if (yc>=0) and (yc<=ih-1) then p:=mf.im.Picture.Bitmap.ScanLine[yc];

p[xc*3]:=b;
p[xc*3+1]:=g;
p[xc*3+2]:=r;
//   mf.im.canvas.Pixels[xc,yc]:=rgb(r,g,b);

   end;
  end;

  {
 if a[xc].y<>a_khak[xc].y then
   if bol then  dec(a[xc].y);
   }
{//    for x:=0 to width do

yc:=ih-a[xc].y-height;
if (yc>=0) and (yc<=ih-1) then p:=mf.im.Picture.Bitmap.ScanLine[yc];

p[xc*3]:=0;
p[xc*3+1]:=0;
p[xc*3+2]:=0;
 }
// mf.im.Canvas.Pixels[xc,{yf-}ih-a[xc].y-height]:=clblack;
  end;

//if i mod 2 =0 then
 mf.im.Repaint;

end;

for x:=xf to xe do
 a[x].y:=a_khak[x].y;


 for x:=0 to width do
  for y:=0 to height do
   mf.im.canvas.Pixels[x+xf,ih-a[x+xf].y-y]:=clblack;


mf.im.Canvas.Pen.Mode:=pmxor;
end;

{--------------------------------}


procedure Soil_Collapse(x1,x2:integer;Have_fire:boolean);
var
nm,j1,i,j,num,j2,xi,xf:Integer;
first:boolean;
col:Tcolor;
//have_fire:boolean;
{-------}
procedure Collapse;
begin

j2:=0;
nm:=0;
repeat
inc(j2);
inc(nm);
until  (get_color(i,ih-(j2))=clblack) or (nm>ih);

 j:=j2+1;
j1:=j2+1;

nm:=0;
while (j1<=a[i].y) and (nm<50000){mf.im.Height} do
begin
inc(nm);
if (get_color(i,ih-j)<>clblack{=cllime}) and
(get_color(i,ih-(j-1))=clblack)
 and (j<=ih+1)
 then
 begin
 col:=get_color(i,ih-j);
 put_color(i,ih-(j2),col);
 put_color(i,ih-j,clblack);
 inc(j2);
 end

 else
 begin
inc(j1);
j:=j1;
end;

end;
//a[i].y:=j2{-1};
a_khak[i].y:=j2-1{-1};
end;
{------------}

begin

if x1<0 then x1:=0;
if x2>iw+1 then x2:=iw+1;


mf.im.Canvas.pen.Mode:=pmcopy;
//have_fire:=true or (random<0.5);
num:=0;
i:=x2+1;

if a[i].y<> a_khak[i].y then
while (a[i].y<>a_khak[i].y) and (i<=iw) and (num<400) do
begin

if not Have_Fire then
begin
collapse;
a[i].y:=a_khak[i].y;
end;
inc(i);
inc(num);
end;

xf:=i;

num:=0;
i:=x1-1;
if a[i].y<>a_khak[i].y then
while (a[i].y<>a_khak[i].y) and (i>0) and (num<400) do
begin

if not Have_Fire then
begin
collapse;
a[i].y:=a_khak[i].y;
end;
dec(i);
inc(num);
end;

xi:=i;


{**************}
if (not ( (x1=0) and (x2=iw))) and Have_Fire then
Make_fire(xi,xf);

{****************}


//else
 {
for i:=xi to x1 do
collapse;

for i:=x2 to xf do
collapse;
  }


for i:={tx-r_explode}x1 to {tx+r_explode}x2 do

if (i>0) and (i<=iw) then
begin
collapse;
 a[i].y:=a_khak[i].y;
end;

for i:=1 to Number do
tank[i].fall;


for i:=x1 to x2 do
 a[i].y:=a_khak[i].y;

for i:=xi to xf do
 a[i].y:=a_khak[i].y;

if not have_fire then soil_roll((x1+x2) div 2);
Show_border;
end;

{--------------------------------}

procedure Soil_Break(x,y,depth:Integer);

function prob:boolean;
begin
result:=(random<0.5{-(sqrt(sqrt(sqr(x-x_break)+sqr(y-y_break)))/20)});
end;


begin
mf.im.Canvas.Pixels[x,y]:=clblack;
if depth  mod 40=0 then mf.im.Repaint;
if (y<ih)and (y>0) and (y>ih-a[x].y) then
begin
{
 if (mf.im.Canvas.Pixels[x-1,y-1]=cllime) and prob then
  Soil_break(x-1,y,depth+1);

 if (mf.im.Canvas.Pixels[x+1,y-1]=cllime) and prob then
  Soil_break(x+1,y,depth+1);

 if (mf.im.Canvas.Pixels[x-1,y+1]=cllime) and prob then
  Soil_break(x-1,y,depth+1);

 if (mf.im.Canvas.Pixels[x+1,y+1]=cllime) and prob then
  Soil_break(x+1,y,depth+1);
 }
                  {------------}

 if (Get_Color(x-1,y)<>clblack{=cllime}) and prob then
  Soil_break(x-1,y,depth+1);

 if (Get_Color(x+1,y)<>clblack{=cllime}) and prob then
  Soil_break(x+1,y,depth+1);


 if (Get_Color(x,y-1)<>clblack{=cllime}) and prob then
  Soil_break(x,y-1,depth+1);

if (Get_Color(x,y+1)<>clblack{=cllime}) and prob then
 Soil_break(x,y+1,depth+1);

end;
end;

{--------------------------------}

procedure Make_G_color(x,y:Integer;r,b:byte);
var
col:Tcolor;
rg:array [1..4] of Integer;
nrg:byte;
rgc,i:integer;
P:Pbytearray;
begin
rgc:=0;
if x<=0 then begin x:=1;rgc:=0*255;end;
if y>=ih+1 then begin y:=ih+1;rgc:=255;end;
if y<=1 then begin y:=1;{rgc:=255;}end;
if x>iw then begin x:=iw;rgc:=255;end;

if y>=ih then rgc:=255;

p:=mf.im.Picture.Bitmap.ScanLine[y];

if x>0 then rg[1]:=p[3*x-2];  //getgvalue(mf.im.Canvas.Pixels[x-1,y]);
rg[2]:=p[3*x+4];  //getgvalue(mf.im.Canvas.Pixels[x+1,y]);
//if y<ih-1 then
p:=mf.im.Picture.Bitmap.ScanLine[y+1];
rg[3]:=p[x*3+1];      //getgvalue(mf.im.Canvas.Pixels[x,y+1]);

 p:=mf.im.Picture.Bitmap.ScanLine[y-1];

rg[4]:= p[x*3+1] ;    //getgvalue(mf.im.Canvas.Pixels[x,y-1]);

nrg:=0;

for i:=1 to 4 do
if rg[i]>0 then begin inc(nrg);rgc:=rgc+rg[i] end;

if nrg>0 then
rgc:= {round(cos(0.25*rgc/50)*20)+}{10}frac_seed-random({21}frac_seed*2+1)+ rgc div nrg else
rgc:=255;

//if random<0.5 then rgc:=rgc+10 else rgc:=rgc-10;
if (rgc>255)  then rgc:=255 else
if  (rgc<=10) then rgc:=10;

//col:=rgb({getrvalue(col)}r,{getgvalue(col)+2-random(4)}rgc,{getbvalue(col)}b );

p:=mf.im.Picture.Bitmap.ScanLine[y];
p[x*3]:=b;
p[x*3+1]:=rgc;
p[x*3+2]:=r;
//mf.im.Canvas.Pixels[x,y]:=col;

end;

{-----------------------------------------------------}


procedure Make_Gray_color(x,y:Integer;depth:Integer);
var
col:Tcolor;
rg:array [1..4] of Integer;
nrg:byte;
rgc,i:integer;

begin

rg[1]:=getrvalue(mf.im.Canvas.Pixels[x-1,y]);
rg[2]:=getrvalue(mf.im.Canvas.Pixels[x+1,y]);
rg[3]:=getrvalue(mf.im.Canvas.Pixels[x,y+1]);
rg[4]:=getrvalue(mf.im.Canvas.Pixels[x,y-1]);
           {
rg[1]:=getgvalue(mf.im.Canvas.Pixels[x-1,y]);
rg[2]:=getgvalue(mf.im.Canvas.Pixels[x+1,y]);
rg[3]:=getgvalue(mf.im.Canvas.Pixels[x,y+1]);
rg[4]:=getgvalue(mf.im.Canvas.Pixels[x,y-1]);

rg[1]:=getbvalue(mf.im.Canvas.Pixels[x-1,y]);
rg[2]:=getbvalue(mf.im.Canvas.Pixels[x+1,y]);
rg[3]:=getbvalue(mf.im.Canvas.Pixels[x,y+1]);
rg[4]:=getbvalue(mf.im.Canvas.Pixels[x,y-1]);
            }

nrg:=4;
rgc:=0;
for i:=1 to 4 do
//if rg[i]>0 then
begin inc(nrg);rgc:=rgc+rg[i]+10 end;

///if nrg>0 then
rgc:= {round(cos(0.25*rgc/50)*20)+}{10}(* frac_seed-random({21}frac_seed*2+1)+*) rgc div (nrg);
//else
//if rgc=0 then rgc:=255;

//if random<0.5 then rgc:=rgc+10 else rgc:=rgc-10;
if (rgc>255)  then rgc:=255 else
//if  (rgc<=0) then rgc:=100;

col:=rgb(rgc,rgc,rgc );

mf.im.Canvas.Pixels[x,y]:=col;

end;

{-----------------------------------------------------}

procedure Make_Bush(x,y,depth:Integer);

function prob:boolean;
begin
result:=(random<0.68-abs(abs(x-x_break)/20-(y-y_break)/{20}tree_height)/20{(sqrt(sqrt(sqr(x-x_break)+sqr(y-y_break)))/20)});
end;


begin
make_g_color(x,y,random(red_max),random(blue_max));

if ih-a[x].y>y then a[x].y:=ih-y;

if depth  mod 90=0 then mf.im.Repaint;
if (y<ih)and (y>0){ and (y>ih-a[x].y) }then
begin
{
 if (mf.im.Canvas.Pixels[x-1,y-1]=cllime) and prob then
  Soil_break(x-1,y,depth+1);

 if (mf.im.Canvas.Pixels[x+1,y-1]=cllime) and prob then
  Soil_break(x+1,y,depth+1);

 if (mf.im.Canvas.Pixels[x-1,y+1]=cllime) and prob then
  Soil_break(x-1,y,depth+1);

 if (mf.im.Canvas.Pixels[x+1,y+1]=cllime) and prob then
  Soil_break(x+1,y,depth+1);
 }
                  {------------}

 if (Get_color(x-1,y)=clblack{=cllime}) and prob then
  Make_Bush(x-1,y,depth+1);

 if (Get_color(x+1,y)=clblack{=cllime}) and prob then
  Make_Bush(x+1,y,depth+1);


 if (Get_color(x,y-1)=clblack{=cllime}) and prob then
  Make_Bush(x,y-1,depth+1);

//if (mf.im.Canvas.Pixels[x,y+1]=clblack{=cllime}) and prob then
// Make_Bush(x,y+1,depth+1);

end;

end;

{--------------------------------}

procedure Add_Bushes;
var
 i,num:Integer;
begin
for i:=1 to random(10) do
begin
mf.im.Canvas.pen.Mode:=pmcopy;

num:=0;
repeat
x_break:={iw div 2}random(iw);;
y_break:=ih-{20}a[x_break].y-1;
inc(num);
until (a[x_break].y=a_khak[x_break].y) or (num>10000);

red_max:=random(200);
blue_max:=random(200);
tree_height:=5+random(5)*10;

if num<10000 then Make_bush(x_break,y_break,1);

mf.im.Canvas.pen.Mode:=pmxor;
end;
end;

{--------------------------------}


procedure Make_Smoke(x,y:Integer);
const
Number=20;

var
 i,j,xx,yy:Integer;
 dis:array [0..Number] of integer;
begin

mf.im.Canvas.Pen.Mode:=pmcopy;

for i:=0 to Number do dis[i]:=0;


for j:=1 to 1000 do
begin
mf.im.Canvas.moveto(x,y);

mf.im.Canvas.Pen.Color:=clblack;

for i:=0 to Number do
mf.im.Canvas.LineTo(x+dis[i],y-3*i);


for i:=0 to Number do
 dis[i]:=dis[i]+i div 2-random(i+1);

mf.im.Canvas.moveto(x,y);

for i:=0 to Number do
begin
mf.im.Canvas.Pen.Color:=rgb(255-20*i,255-20*i,255-20*i);
mf.im.Canvas.LineTo(x+dis[i],y-3*i);
end;
{
for xx:=x-20 to x+20 do
 for yy:=y-3*Number to y do
  make_gray_color(xx,yy,1);
 }

mf.im.Repaint;
end;

mf.im.Canvas.Pen.Mode:=pmxor;

 end;

{--------------------------------}


procedure TTank.draw_pipe;
var
x2,y2:Integer;
begin

mf.Im.Canvas.pen.Color:=rgb(getrvalue(claqua)*life div 100,getgvalue(claqua)*life div 100,getbvalue(claqua)*life div 100);
x2:=x+round(bc(c));
y2:=y-round(ab(c));
line(x,y,x2,y2);

//mf.Im.Refresh;
end;

{--------------------------------}

procedure TTank.Draw_Body;
begin
mf.im.canvas.copymode:=cmSrcInvert;
mf.im.Canvas.Draw(x-16,y-12,pic);
end;

{------------------------------------------------------------------------------}

procedure TTank.Draw_Body_first;
begin
mf.im.canvas.copymode:=cmSrcPaint	;
mf.im.Canvas.Draw(x-16,y-12,pic);
end;

{------------------------------------------------------------------------------}
procedure ttank.change_color;
var
xp,yp,lifet:Integer;
col:Tcolor;
begin
lifet:=life;
if life<0 then lifet:=0;
pic.LoadFromFile('tank.bmp');
for xp:=0 to pic.Width do
 for yp:=0 to pic.Height do
 begin
  col:=pic.Canvas.Pixels[xp,yp];
  pic.Canvas.Pixels[xp,yp]:=rgb(getrvalue(col)*lifet div 100,getgvalue(col)*lifet div 100,getbvalue(col)*lifet div 100);
 end;

end;


{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

procedure TTank.Field(x_exp,y_exp,power:integer);
const
ghodrat=200{300{135000};
var
d,f:single;

begin
if boodan then
begin
d:=sqrt (sqr(x_exp-x)+sqr(y_exp-y));

if d>r_explode*2 then d:=10000;
d:=sqr(d);


if d=0 then d:=1;
f:=ghodrat*power/d;
life:=round(life-f);

if life<=0 then explode;

change_color;

if v_i>life*10 then
begin
v_i:=life*10;

end;

end;
end;
{------------------------------------------------------------------------------}


procedure Ttank.Fall;
var
q,i:integer;
empty:boolean;
y_f:integer;
begin
y_f:=y;
repeat

q:=0;
for i:=0 to 31 do
if mf.im.Canvas.Pixels[x-16+i,y+21]=clblack then inc(q);
if q>=10 then
begin
//draw_body;
y:=y+1;
//draw_body;
end;

until  q<10;
//show_all_pipe;
life:= life-abs(y-y_f)*2;
change_color;
if (life<=0) and boodan then explode;
end;


{------------------------------------------------------------------------------}


procedure Do_explode(tx,ty,r_explode:integer);
var
i,j,rg:integer;
col:Tcolor;
rr:Single;

{---------}

procedure Show_exp;
var
 c:Integer;
begin
i:=r_explode;
while i>=1 do
begin
c:=round(j*rr*(r_explode-i)/r_explode);
col:=rgb(255*c,rg*c,0);
mf.im.Canvas.pen.color:=col;
mf.im.Canvas.Brush.Color:=col;
circle(tx,ty,i);
dec(i,2);
end;

end;
{--------}

begin
playsound('launch.wav',0,SND_ASYNC);

mf.im.Canvas.pen.Mode:=pmcopy;

rr:=(1+random(10))/10;
rg:=random(6)*10;

for j:=1 to 10 do
begin
show_exp;
mf.im.Canvas.pen.Mode:=pmxor;
show_all_pipe;
mf.im.Repaint;
show_all_pipe;
mf.im.Canvas.pen.Mode:=pmcopy;

end;

for j:=10 downto 1 do
begin
show_exp;
end;


mf.im.Canvas.pen.color:=clblack;
mf.im.Canvas.brush.color:=clblack;
circle(tx,ty,r_explode);
mf.im.Canvas.pen.Mode:=pmxor;

//mf.im.repaint;
for i:=1 to Number do
tank[i].field(tx,ty,100);

Show_Border;

end;

{-----------------------}

procedure Ttank.Explode;
var
 max_r,kind,xe,ye:Integer;
{-----internal procedure------}
procedure exp1;
var
 i,j:Integer;
begin
max_r:=5+random(5)*10;
for i:=1 to 10 do
 begin
  xe:=x+max_r-random(max_r*2+1);
  ye:=y+max_r-random(max_r*2+1);
  do_explode(xe,ye,10);
  for j:=1 to Number do if tank[j].boodan then tank[j].Field(xe,ye,50);
 end;

  do_explode(x,y,r_explode);
  for j:=1 to Number do if tank[j].boodan then tank[j].Field(x,y,100)
end;
{---internal procedure---}
procedure exp2;
var
j:Integer;
begin
do_explode(x,y,70);
for j:=1 to Number do if tank[j].boodan then tank[j].Field(x,y,200)
end;
{------}

begin
show_all_pipe;
boodan:=false;

if tank[k].boodan then {in shart baraye in ast ke agar tank khod ra zad pool bedast nayavarad}
tank[k].money:=tank[k].money+500;

kind:=1+random(2);
case kind of
1:exp1;
2:exp2;
end;
soil_collapse(0,iw,false);
show_all_pipe;
end;

{------------------------------------------------------------------------------}


procedure Bullet_Motion;

var
khord,tank_khord:boolean;
tx,ty,i:integer;
t:Single;
px,py,vx,vy,h:Single;
num:integer;
{-------------------------}
{
function b_p_y(t:Single):Integer ;
begin

result:=round( (tank[k].y-(ab(tank[k].c)) )-(( tank[k].vy*t )+(0.5*g*t*t) ));
end;
{------------------------------}
{
function b_p_x(t:Single):Integer;
begin
result:=round( (tank[k].x+(bc(tank[k].c)))+(tank[k].vx*t));
end;

{---------}

procedure Bullet_in_soil;
begin
if {mf.im.canvas.Pixels[round(px),round(py)]=cllime
}
 (py>ih-a[round(px)].y) and  (mf.im.Canvas.Pixels[round(px),round(py)]<>clblack)
 then
 begin
 if sqrt(sqr(vx)+sqr(vy)) >50 then
 begin
  vx:=vx*0.932{978};vy:=vy*0.932{978};
  mf.im.Canvas.Pen.Mode:=pmcopy;
  mf.im.Canvas.Pixels[round(px),round(py)]:=clblack;
  mf.im.Canvas.Pen.Mode:=pmxor;
  end
 else
  khord:=true;
 end;
end;

{------------------------------------------------------------------------------}

procedure bullet_reflex;
begin

if (px<0) or (px>iw) then
begin
px:=px-vx*h;
vx:=-vx;
end;


if (py<0) or (py>ih) then
begin
py:=py-vy*h;
vy:=-vy;
end;

end;


{---------------------------------------------------------------------------------------}
begin

vx:= cos(d_r(tank[k].c))*tank[k].v_i ;
vy:=- sin(d_r(tank[k].c))*tank[k].v_i ;

px:=(tank[k].x+(bc(tank[k].c)));
py:=(tank[k].y-(ab(tank[k].c)) );


t:=0;
num:=0;
h:=0.0003;
mf.im.Canvas.Pixels[round(px),round(py)]:=clwhite;
khord:=false;
tank_khord:=false;
repeat

mf.im.Canvas.Pixels[round(px),round(py)]:=clwhite;

t:=t+h;
inc(num);

px:=px+vx*h;
py:=py+vy*h;

vy:=vy+g*h;
//vx:=vx+1;

//h:=2/sqrt(sqr(vx)+sqr(vy));

//mf.im.Repaint;

bullet_reflex;

bullet_in_soil;

mf.im.Canvas.Pixels[round(px),round(py)]:=clwhite;
if num mod 28=0 then mf.im.Repaint;

//khord:=khord;
tank_khord:=barkhord(round(px),round(py),num);

until (khord or tank_khord);

if khord or tank_khord then
begin

show_all_pipe;

if not Tank_khord then do_explode(round(px),round(py),r_explode);
show_all_pipe;


mf.im.Repaint;
show_all_pipe;

if py-r_explode<ih-a_khak[round(px)].y-10 then
soil_collapse(round(px-r_explode),round(px+r_explode),true)
else
soil_collapse(round(px-r_explode),round(px+r_explode),false);

show_all_pipe;

//num:=0;

{
for i:=1 to Number  do
if tank[i].boodan then inc (num);

if num<2 then init;
}

end;
{
if tank_khord=true and  then
tank[k].money:=tank[k].money+500;
}
end;

{--------------------------------}
procedure TTank.clean_pipe;

var
x2,y2:Integer;

begin
mf.Im.Canvas.pen.Color:=rgb(getrvalue(claqua)*life div 100,getgvalue(claqua)*life div 100,getbvalue(claqua)*life div 100);
//mf.im.Canvas.Pen.Mode:=pmcopy;
//mf.im.Canvas.Pen.Color:=clblack;
mf.im.Canvas.Pen.Mode:=pmxor;
x2:=x+round(bc(C_C));
y2:=y-round(ab(C_c));
line(x,y,x2,y2);
//mf.im.Canvas.Pen.Mode:=pmxor;
end;

{------------------------------}
procedure computer_player;forward;
procedure Turn;

var
num,m,i:Integer;
bol:boolean;
s:shortstring;
begin
num:=0;

bol:=false;
for i:=1 to Number do
bol:=bol or tank[i].boodan;

if bol then
begin

if first then
begin
k:=1+random(Number);
first:=false;
end;

repeat

if k=Number then k:=0;
k:=k+1;

until (tank[k].boodan=true) ;

end;

 str(round(tank[k].c),s);
 mf.lab_c.Caption:=s;

 str(tank[k].v_i,s);
 mf.lab_v.Caption:=s;
 mf.lab_n.Caption:=tank[k].name;
// if k=1 then computer_player;
 str(tank[k].money,s);
 mf.lab_money.caption:=s;
{
 str(tank[k].wins,s);
 mf.lab_wins.caption:=s;
  }

 for i:=1 to Number  do
if tank[i].boodan then inc (num);

if num<2 then
begin
tank[k].wins:=tank[k].wins+1;

str(tank[k].wins,s);
 mf.lab_wins.caption:=s;
{if counter_level>2 then halt; }
init;
end;

 end;



{-------------------------------}

function shortest_distance(loop1,frx1,fry1:integer;q:a_t):integer ;
var
fs1,t1,fs,t,i:integer;

begin
fs:=10000;
t:=fs;
fs1:=10000;
t1:=fs1;

for i:=1 to loop1 do
 Begin

 fs:=round(sqrt(sqr(frx1-q[i].x)+sqr(fry1-q[i].y)));
 if fs<t then t:=fs;
 {
 if p then
  begin

   for z:=1 to 10 do
    begin

    fs1:=round(sqrt(sqr(frx1-j[z].x)+sqr(fry1-j[z].y)));
    if fs1<t1 then t1:=fs1;

    end;

  end;

     }
 end;


shortest_distance:=t


end;

{-------------------------------}

procedure q_f_soil;forward
procedure soil;forward;


procedure q_f_T{quintity first of pipes};
var
ra,j,s,rx,ry,count:integer;
begin
for j:=1 to Number do
begin
count:=0;

if j>1 then
repeat

ra:=20+random(iw-20);
rx:=ra;
ry:=ih-(a[ra].y+l_pipe);
s:=shortest_distance(j,rx,ry,tank);
inc(count);

until ((s>40)  and (not Try_fall(round(rx),round(ry)))) or (count>30000);

if j=1 then
begin
ra:=20+random(iw-20);
rx:=ra;
ry:=ih-(a[ra].y+l_pipe);
end;
with tank[j] do
begin
x:=rx;
y:=ry;
shift:=false;
c:=5;//random(180);
v_i:=200;
boodan:=true;
life:=100;
pic.LoadFromFile('tank.bmp');
end;
{
tank[1].name:='Nima';
tank[2].name:='Kamran';
 }
end;

add_bushes;

end;

{-------------------------------}



Procedure Tmf.FormKeyDown(Sender: TObject; Var KEY: Word;
    Shift: TShiftState);

var
s:string;
Begin

  Case KEY Of

    VK_RIGHT:
     begin
     tank[k].c_c:=tank[k].c;
     tank[k].c:=tank[k].c-d_angle;
     if tank[k].c<=0 then tank[k].c:=360;



     tank[k].clean_pipe;



     tank[k].draw_pipe;
     str(round(tank[k].c),s);
     mf.lab_c.Caption:=s;
     end;


    VK_LEFT:
      begin
      tank[k].c_c:=tank[k].c;

      tank[k].c:=tank[k].c+d_angle;
     if tank[k].c>=360 then tank[k].c:=0;



      tank[k].clean_pipe;

      tank[k].draw_pipe;
       str (round(tank[k].c),s);
       mf.lab_c.Caption:=s;
      end;


    VK_UP:
    Begin
    tank[k].v_i:=tank[k].v_i+d_angle;
    if tank[k].v_i>tank[k].life*10 then tank[k].v_i:=tank[k].life*10;
     str (tank[k].v_i,s);
     mf.lab_v.Caption:=s;
    end;

    VK_DOWN:
    begin
    tank[k].v_i:=tank[k].v_i-d_angle;
    if tank[k].v_i<0 then tank[k].v_i:=0;
    str (tank[k].v_i,s);
    mf.lab_v.Caption:=s;
    end;

    VK_PRIOR:
    begin
    tank[k].v_i:=tank[k].v_i+200;
    if tank[k].v_i>tank[k].life*10 then tank[k].v_i:=tank[k].life*10;



    str (tank[k].v_i,s);
    mf.lab_v.Caption:=s;
    end;

    VK_NEXT:
    Begin
     tank[k].v_i:=tank[k].v_i-200;
    if tank[k].v_i<0 then tank[k].v_i:=0;
    str(tank[k].v_i,s);
    mf.lab_v.Caption:=s;
    end;
   // VK_PRIOR:computer_player;

   end;

   mf.lab_v.Repaint;
   mf.lab_c.Repaint;

   end; {_ Procedure Tmf.FormKeyDown(Sender: TObject; Var KEY: Word; _}

{---------------------------------------------------}

procedure Tmf.startClick(Sender: TObject);
begin
init;
end;



procedure Tmf.FormCreate(Sender: TObject);
var
i:integer;

begin
//Number:=10;
counter_level:=0;
im.Picture.Bitmap.PixelFormat:=pf24bit;
im.Picture.Bitmap.Height:=im.Height+50;
im.Picture.Bitmap.Width:=im.width+50;

for i:=1 to  {Number}10 do
begin
tank[i]:=TTank.Create;
tank[i].pic:=Tbitmap.Create;
tank[i].pic.LoadFromFile('tank.bmp');
end;


randomize;
iw:=mf.im.Width-1;
ih:=mf.im.Height-1;
for i:=1 to  Number do
begin
tank[i].wins:=0;
tank[i].money:=0;
end;

//init;

end;



{-------------------------------}

procedure Fire;
var
i:integer;
bol:boolean;
begin
playsound('firing.wav',0,SND_ASYNC);
bol:=false;
for i:=1 to Number do
bol:=bol or tank[i].boodan;
if bol then
bullet_motion;
turn;


end;




{-----------------------------------------------------}

procedure Computer_player;
var
ra:integer;
Y,PART_1,PART_2,beta,L,c,d:double;
s:string;
ALFA,X:DOUBLE;
sender:tobject;
begin

repeat
ra:=random(Number)+1;
until  (ra<>k) and (tank[ra].boodan);
//d:=abs(tank[ra].x-tank[k].x) /2 ;

L:=ABS(tank[ra].x-tank[k].x);
(*
beta:=abs(tank[ra].y-tank[k].y);
Y:=tank[k].y;
part_1:=(L*(1-(BETA/2*Y-BETA)))/2;
PART_2:=(BETA*L)/(2*Y-BETA);
c:=RADTODEG{DEGTORAD}(arctan((y/(PART_1+PART_2))));
*)

//halt;
beta:={abs}-(tank[ra].y-tank[k].y);
Y:=tank[k].y;
ALFA:=L*(1-(BETA/(2*Y-BETA)))/2;
X:=BETA*{ALFA}L/(2*Y-BETA);
C:=RADTODEG(ARCTAN(Y/(ALFA+X)));

IF (tank[ra].x-tank[k].x)<0 THEN C:=180-C;

tank[k].c:=c;

tank[k].v_i:=tank[k].life*10;;
str(tank[k].v_i,s);
mf.lab_v.Caption:=s;


str(round(tank[k].c),s);
mf.lab_c.Caption:=s;
//Fire;
end;

{---------------------------------------------------------------------------}

//procedure Computer_player;forward;
procedure Tmf.FormKeyPress(Sender: TObject; var Key: Char);
begin
case key of

 ' ':fire;

 {
 VK_RIGHT:
 VK_LEFT:
 VK_UP:
 VK_DOWN:
  }
  end;
  end;


{------------------------------}
procedure q_f_soil;
const
ihh=0;
var
i:integer;
j:integer;
fig:byte;
begin

fig:=random(10);
a[-1].y:=5;

for i:=0 to iw do
begin

case fig of
0:a[i].y:=ihh+round(sin(cos(i/319.4234)*i/30)*50) ;
1:a[i].y:=ihh+round(i/5)+100-random(200);
2:a[i].y:=ihh+round(sin(i/30)*50);
3:a[i].y:=60+ihh+round(sin(i/30)*50/(abs(cos(i/35))+0.23));
4:a[i].y:=ihh+abs(a[i-1].y+5-random(11));
5:a[i].y:=ihh+round((iw div 2 -abs(i-iw div 2)) /1.5) ;
6:a[i].y:=ihh+round(abs(sin(i/20))* (iw div 2 -abs(i-iw div 2)) /1.5) ;
7:a[i].y:=ihh+round((sin(i/20)+1)* (iw div 2 -abs(i-iw div 2)) /3) ;
8:a[i].y:=ihh+round(sqr(sqr(cos(2*(i-iw div 2)/iw)))*200) ;
9:a[i].y:=ihh+round(sqr(sqr(sqr(cos(2*(i-100)/iw))))*200) ;
10:a[i].y:=ihh+round(sqr(sqr(sqr(cos(2*(i-100+iw)/iw))))*200) ;
end;
 

for j:=0 to a[i].y do
 make_g_color(i,ih-j,0,0);
end;
   {
mf.im.Canvas.pen.color:=cllime;
for j:=0 to iw do
begin
mf.im.canvas.MoveTo(j,mf.im.Height);
mf.im.canvas.lineto(j,ih-(a[j].y+1));
end;
}

end;


{------------------------------}


procedure Soil;
var
r:integer;
i,volume:integer;
min:integer;
begin


for volume:=1 to 40000{60000} do
 begin
r:=random(iw);
min:=r-1;
for i:=r-1 to r+1 do
if a[i].y<a[min].y  then
min:=i;
a[min].y:=a[min].y+1;



//mf.im.Canvas.Pixels[min,ih-a[min].y]:=col;
make_g_color(min,ih-a[min].y,0,0);

 // if volume mod 5 =0 then
//  col:=rgb(getrvalue(col),{getgvalue(col)+2-random(4)}rg,getbvalue(col) )

//if volume mod 100000=0 then mf.im.Repaint;

 end;

a_khak:=a;

end;

{--------------------------------}


procedure Show_Border;
var
t:TPenMode;
begin
t:=mf.im.Canvas.Pen.Mode;
mf.im.Canvas.Pen.Mode:=pmcopy;
mf.im.Canvas.Pen.Color:=clgray;
mf.im.Canvas.MoveTo(0,0);
mf.im.Canvas.lineTo(mf.im.Width-1,0);
mf.im.Canvas.lineTo(mf.im.Width-1,mf.im.Height);
mf.im.Canvas.lineTo(0,mf.im.Height);
mf.im.Canvas.lineTo(0,0);
mf.im.Canvas.Pen.Mode:=t;
end;


procedure Init;
var
i:Integer;
begin
//Number:=number;
//if counter_level>2 then halt;
inc(counter_level);
if counter_level>mf2.Spin_e_Level.Value then halt;

with mf do
begin

b:=true;
first:=true;
mf.im.Canvas.Pen.Mode:=pmxor;

k:=0;
b:=true;
mf.im.Canvas.brush.Color:=clblack;
mf.im.Canvas.FillRect(rect(0,0,iw+2,ih+2));

show_border;

frac_seed:=1+random(10)*5;

q_f_soil;

volume:=0;

soil;


q_f_T;
turn;

for i:=1 to Number do
begin
 mf.im.Canvas.Pen.Mode:=pmcopy;
 tank[i].Draw_Body_first;
 mf.im.Canvas.Pen.Mode:=pmxor;
 tank[i].draw_pipe;
end;


end;
end;

{-------------------------------}


procedure Tmf.SpeedButton1Click(Sender: TObject);
begin

x_break:=iw div 2{random(iw)};;
y_break:=ih div 2{-{20}{a[x_break].y-1};


red_max:=random(200);
blue_max:=random(200);
//tree_height:=5+random(5)*10;

//Make_Smoke(x_break,y_break);
Make_fire2(x_break,x_break+100);
end;

procedure Tmf.SpeedButton2Click(Sender: TObject);
var
 i:Integer;
begin
//add_bushes;
mf.im.Canvas.pen.Mode:=pmcopy;
mf.im.Canvas.moveTo(0,ih-a[0].y);
{
mf.im.Canvas.Pen.Color:=clwhite;
 for i:=0 to iw do
  mf.im.Canvas.LineTo(i,ih-a[i].y);
mf.im.Canvas.Pen.Color:=claqua;

mf.im.Canvas.moveTo(0,ih-a[0].y);
 }
 for i:=0 to iw do
  if (a[i].y=a_khak[i].y) then 
  mf.im.Canvas.pixels[i,ih-a_khak[i].y]:=claqua;



  mf.im.Canvas.pen.Mode:=pmxor;
end;

procedure Tmf.SpeedButton3Click(Sender: TObject);
begin
soil_collapse(0,iw,false);
end;

procedure Tmf.FormShow(Sender: TObject);
begin
init;
end;

end.

