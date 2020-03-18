unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    mOutput: TMemo;
    procedure Button1Click(Sender: TObject);
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

end.
