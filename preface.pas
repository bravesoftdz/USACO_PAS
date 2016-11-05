{
ID:kjinxin1
PROG:preface
LANG:PASCAL
}
const
  change:array[1..4,0..9] of string=(('','I','II','III','IV','V','VI','VII','VIII','IX'),
                                     ('','X','XX','XXX','XL','L','LX','LXX','LXXX','XC'),
                                     ('','C','CC','CCC','CD','D','DC','DCC','DCCC','CM'),
                                     ('','M','MM','MMM','','','','','',''));
  g:array[1..7] of char=('I','V','X','L','C','D','M');
var
  ans:array['A'..'Z'] of longint;
  n,i:longint;
procedure try1(t:longint);
var
  i,j:longint;
  st:string;
begin
  j:=trunc(ln(t)/ln(10))+1;
  st:='';
  for i:= 1 to j do
    begin
      st:=st+change[i,t mod 10];
      t :=t div 10;
    end;
  for i:= 1 to length(st) do
    begin
      inc(ans[st[i]]);
    end;
end;
begin
  assign(input,'preface.in');
  reset(input);
  assign(output,'preface.out');
  rewrite(output);
  fillchar(ans,sizeof(ans),0);
  readln(n);
  for i:= 1 to n do
    begin
      try1(i);
    end;
  for i:= 1 to 7 do
    begin
      if ans[g[i]]>0 then
        begin
          writeln(g[i],' ',ans[g[i]]);
        end;
    end;
  close(input);
  close(output);
end.