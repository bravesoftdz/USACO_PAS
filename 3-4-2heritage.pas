{
ID:kjinxin1
PROG:heritage
LANG:PASCAL
}
var
  g1,g2:array[0..30] of char;
  hash:array['A'..'Z'] of longint;
  i,j,r1,r2,l1,l2:longint;
procedure init;
var
  i,j:longint;
begin
  fillchar(g1,sizeof(g1),0);
  fillchar(g2,sizeof(g2),0);
  fillchar(hash,sizeof(hash),0);
  r1:=0; r2:=0;
  while not eoln do
    begin
      inc(r1); read(g1[r1]);
      hash[g1[r1]]:=r1;
    end;
  readln;
  while not eoln do
    begin
      inc(r2); read(g2[r2]);
    end;
end;
procedure try1(l1,r1,l2,r2:longint);
var
  l,mid:longint;
begin
  if l1>r1 then exit;
  if l1=r1 then
    begin
      write(g1[l1]);
      exit;
    end;
  mid:=hash[g2[l2]];
  l:=mid-l1;
  try1(l1,mid-1,l2+1,l2+l);
  try1(mid+1,r1,l2+l+1,r2);
  write(g2[l2]);
end;
begin
  assign(input,'heritage.in'); reset(input);
  assign(output,'heritage.out'); rewrite(output);
  init;
  try1(1,r1,1,r2);
  writeln;
  close(input); close(output);
end.