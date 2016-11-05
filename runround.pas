{
ID:kjinxin1
PROG:runround
LANG:PASCAL
}
var
  m,t:longint;
  g:array[0..12] of longint;
  hash:array[0..9] of boolean;
  top,i,j:longint;
  o,u:boolean;
procedure try1(t:longint);
var
  i,j:longint;
begin
  fillchar(hash,sizeof(hash),0);
  top:=0;
  while t>0 do
    begin
      j:= t mod 10;
      inc(top);
      if (j=0) or hash[j] then
        begin
          exit;
        end;
      hash[j]:=true;
      g[top]:=j;
      t:= t div 10;
    end;
  u:=true;
end;
function  judge:boolean;
var
  k,i,j:longint;
begin
  for i:= 1 to top shr 1 do
    begin
      j:=g[i]; g[i]:=g[top-i+1]; g[top-i+1]:=j;
    end;
  fillchar(hash,sizeof(hash),0);
  hash[g[1]]:=true;
  j:=(g[1]+1) mod top;
  if j=0 then j:=top; k:=0;
  for i:= 1 to top-1 do
    begin
      if hash[g[j]] then exit(false);
      hash[g[j]]:=true;
      j:=(g[j]+j) mod top;
      if j=0 then j:=top;
      inc(k);
    end;
  if (j=1)and (k=top-1) then judge:=true
  else exit(false);
end;
begin
  assign(input,'runround.in');
  reset(input);
  assign(output,'runround.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(hash,sizeof(hash),0);
  readln(m);
  o:=true;
  while o do
    begin
      inc(m);
      u:=false;
      try1(m);
      if u and judge then
        begin
          o:=false;
        end;
    end;
  writeln(m);
  close(input); close(output);
end.
