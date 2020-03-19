unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    mOutput: TMemo;
    bConvertToString: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure bConvertToStringClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  binstrutils;


procedure TForm1.bConvertToStringClick(Sender: TObject);
var
  binstr: string;
  err: integer;
begin
  binstr := BinStrToStr(mOutput.SelText, bsSpace, err);
  showmessage('binstr: ' + binstr);
  showmessage('length of str: ' + inttostr(length(binstr)));
  showmessage('..err code: ' + inttostr(err));
  if err > 0 then begin
    showmessage('err code: ' + inttostr(err));
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var workstr: string;
begin
  workstr := ansistringtobinarystring('ab', bsNone);
  mOutput.Lines.Add(workstr);
  workstr := ansistringtobinarystring('ab', bsPipe);
  mOutput.Lines.Add(workstr);
  workstr := ansistringtobinarystring('ab', bsSpace);
  mOutput.Lines.Add(workstr);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
begin
  i := 12 mod 8;
  showmessage(inttostr(i));
  i :=16 mod 8;
  showmessage(inttostr(i));

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  b: byte;
  s: string;
begin
  b := ord('a');
  // showmessage(inttostr(ord(b)));
  b := SetBit(b, 1);
  // change to "c"
  mOutput.Lines.Add(char(b));
  mOutput.Lines.Add(
                    inttostr(ord(b))
                   );

 // change a to b
  b := ord('a');
  b := SetBit(b, 1);
  b := ClearBit(b, 0);
  mOutput.Lines.Add(char(b));
  mOutput.Lines.Add(
                    inttostr(ord(b))
                   );


end;

procedure TForm1.Button4Click(Sender: TObject);
var
  s: string;
  err: integer;
  rslt, rslt2: string;
begin
  s:= '00000000';
  rslt := BinStrToStr(s, bsSpace, err);
  showmessage('rslt: ' + rslt);
  rslt2 := AnsiStringToBinaryString(rslt, bsSpace);
  showmessage('rslt2: '+rslt2);
end;

end.
