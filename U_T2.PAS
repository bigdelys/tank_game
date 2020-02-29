unit U_T2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Spin;

type
  Tmf2 = class(TForm)
    Start_game: TSpeedButton;
    Edit_n1: TEdit;
    edit_n2: TEdit;
    edit_n3: TEdit;
    edit_n4: TEdit;
    edit_n5: TEdit;
    edit_n6: TEdit;
    edit_n7: TEdit;
    edit_n8: TEdit;
    edit_n9: TEdit;
    edit_n10: TEdit;
    lab_names: TLabel;
    Label1: TLabel;
    Spin_E_N: TSpinEdit;
    Exit: TSpeedButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Spin_e_Level: TSpinEdit;
    spin_ver: TStaticText;
    procedure Spin_E_NChange(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure Start_gameClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure Edit_n1Change(Sender: TObject);
    procedure edit_n2Change(Sender: TObject);
    procedure edit_n3Change(Sender: TObject);
    procedure edit_n4Change(Sender: TObject);
    procedure edit_n5Change(Sender: TObject);
    procedure edit_n6Change(Sender: TObject);
    procedure edit_n7Change(Sender: TObject);
    procedure edit_n8Change(Sender: TObject);
    procedure edit_n9Change(Sender: TObject);
    procedure edit_n10Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mf2: Tmf2;
  //number:Integer;
implementation

uses U_T;

{$R *.DFM}

//var
//n_player:Integer;
{------------------------------------------------------------------------------}
procedure show_edit_n(n_player:Integer);
begin
mf2.Edit_n10.Visible:=false;
mf2.Edit_n9.Visible:=false;
mf2.Edit_n8.Visible:=false;
mf2.Edit_n7.Visible:=false;
mf2.Edit_n6.Visible:=false;
mf2.Edit_n5.Visible:=false;
mf2.Edit_n4.Visible:=false;
mf2.Edit_n3.Visible:=false;
{
mf2.Edit_n2.Visible:=false;
mf2.Edit_n1.Visible:=false;
}

if n_player>=10 then
mf2.Edit_n10.Visible:=true;
if n_player>=9 then
mf2.Edit_n9.Visible:=true;
if n_player>=8 then
mf2.Edit_n8.Visible:=true;
if n_player>=7 then
mf2.Edit_n7.Visible:=true;
if n_player>=6 then
mf2.Edit_n6.Visible:=true;
if n_player>=5 then
mf2.Edit_n5.Visible:=true;
if n_player>=4 then
mf2.Edit_n4.Visible:=true;
if n_player>=3 then
mf2.Edit_n3.Visible:=true;
if n_player>=2 then
mf2.Edit_n2.Visible:=true;
if n_player>=1 then
mf2.Edit_n1.Visible:=true;


end;


{------------------------------------------------------------------------------}

procedure Tmf2.Spin_E_NChange(Sender: TObject);
begin
Number:=spin_e_n.Value;;
show_edit_n(number);
end;
{------------------------------------------------------------------------------}
procedure Tmf2.ExitClick(Sender: TObject);
begin
Halt;
end;

procedure Tmf2.Start_gameClick(Sender: TObject);
begin
mf.show;
end;

procedure Tmf2.FormShow(Sender: TObject);
begin
number:=spin_e_n.Value;
//show_edit_n(number);
tank[1].name:=Edit_n1.text;
tank[2].name:=Edit_n2.text;
tank[3].name:=Edit_n3.text;
tank[4].name:=Edit_n4.text;
tank[5].name:=Edit_n5.text;
tank[6].name:=Edit_n6.text;
tank[7].name:=Edit_n7.text;
tank[8].name:=Edit_n8.text;
tank[9].name:=Edit_n9.text;
tank[10].name:=Edit_n10.text;
end;

procedure Tmf2.HelpClick(Sender: TObject);
begin
//mf3.show;
end;

procedure Tmf2.Edit_n1Change(Sender: TObject);
begin
tank[1].name:=Edit_n1.text;
end;

procedure Tmf2.edit_n2Change(Sender: TObject);
begin
tank[2].name:=edit_n2.Text;
end;

procedure Tmf2.edit_n3Change(Sender: TObject);
begin
tank[3].name:=edit_n3.Text;
end;

procedure Tmf2.edit_n4Change(Sender: TObject);
begin
tank[4].name:=edit_n4.Text;
end;

procedure Tmf2.edit_n5Change(Sender: TObject);
begin
tank[5].name:=edit_n5.Text;
end;

procedure Tmf2.edit_n6Change(Sender: TObject);
begin
tank[6].name:=edit_n6.Text;
end;

procedure Tmf2.edit_n7Change(Sender: TObject);
begin
tank[7].name:=edit_n7.Text;
end;

procedure Tmf2.edit_n8Change(Sender: TObject);
begin
tank[8].name:=edit_n8.Text;
end;

procedure Tmf2.edit_n9Change(Sender: TObject);
begin
tank[9].name:=edit_n9.Text;
end;

procedure Tmf2.edit_n10Change(Sender: TObject);
begin
tank[10].name:=edit_n10.Text;
end;

end.
