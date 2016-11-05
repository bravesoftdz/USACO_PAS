{
ID:kjinxin1
PROG:msquare
LANG:PASCAL
}
const
  data:array[1..8] of longint=(9991,7913,9861,11987,54319,17937,9171,37363);
  max=999991;
type
  node=record
    c:array[1..8] of integer;
    time,fa:longint;
    ch:char;
  end;
  dd=array[1..200000] of node;
var
  b,a:dd;
  hash1,hash2:array[1..1000000] of longint;
  c,d:array[1..8] of integer;
  l1,l2,r1,r2,i,kk,j,time,t:longint;
  o,u:boolean;
function try1(t,t1,r1:longint; var j:longint):boolean;
var
  i:longint;
  u:boolean;
begin
  u:=false;
  while not u and (hash1[t]<>0) do
    begin
      for i:= 1 to 8 do
        begin
          if c[i]<>a[hash1[t]].c[i] then
            begin
              u:=true; break;
            end;
        end;
      if not u then
        begin
          u:=true; break;
        end else u:=false;
      inc(t);
      if t=max then t:=0;
    end;
  j:=hash1[t];
  if (t1=1) and not u then hash1[t]:=r1;
  try1:=not u;
end;
function try2(t,t2,r2:longint; var j:longint):boolean;
var
  i:longint;
  u:boolean;
begin
  u:=false;
  while not u and (hash2[t]<>0) do
    begin
      for i:= 1 to 8 do
        begin
          if c[i]<>b[hash2[t]].c[i] then
            begin
              u:=true; break;
            end;
        end;
      if not u then
        begin
          u:=true; break;
        end else u:=false;
      inc(t);
      if t=max then t:=0;
    end;
  j:=hash2[t];
  if (t2=1) and not u then hash2[t]:=r2;
  try2:=not u;
end;
procedure search2(var l2,r2:longint; ch:char);
var
  i,t,j:longint;
begin
  t:=0;
  for i:= 1 to 8 do
    begin
      t:=t+data[i]*sqr(c[i]);
    end;
  t:= t mod max;
  if try2(t,1,r2+1,j) then
    begin
      inc(r2); b[r2].c:=c;
      b[r2].time:=b[l2].time+1; b[r2].ch:=ch;  b[r2].fa:=l2;
      if not try1(t,0,0,j) then
        begin
          o:=true;
          kk:=j;
        end;
    end;
end;
procedure search1(var l1,r1:longint; ch:char);
var
  i,t,j:longint;
begin
  t:=0;
  for i:= 1 to 8 do
    begin
      t:=t+data[i]*sqr(c[i]);
    end;
  t:= t mod max;
  if try1(t,1,r1+1,j) then
    begin
      inc(r1); a[r1].c:=c;
      a[r1].time:=a[l1].time+1; a[r1].ch:=ch; a[r1].fa:=l1;
      if not try2(t,0,0,j) then
        begin
          o:=true;
          kk:=j;
        end;
    end;
end;
procedure print1(t:longint);
begin
  if t>1 then
    begin
      print1(a[t].fa);
      write(a[t].ch);
    end;
end;
procedure print2(t:longint);
begin
  if t>1 then
    begin
      write(b[t].ch);
      print2(b[t].fa);
    end;
end;
begin
  assign(input,'msquare.in');
  reset(input);
  assign(output,'msquare.out');
  rewrite(output);
  fillchar(b,sizeof(b),0);
  fillchar(a,sizeof(a),0);
  fillchar(hash1,sizeof(hash1),0);
  fillchar(hash2,sizeof(hash2),0);
  fillchar(c,sizeof(c),0);
  l2:=1; l1:=1; t:=0;
  for i:= 1 to 8 do
    begin
      a[l1].c[i]:=i;
      t:=sqr(i)*data[i]+t;
    end;
  t:=t mod max; hash1[t]:=1; t:=0;
  for i:= 1 to 8 do
    begin
      read(b[l2].c[i]);
      t:=sqr(b[l2].c[i])*data[i]+t;
    end;
  t:=t mod max; hash2[t]:=1;
  l1:=1; r1:=1;
  while (l1<=r1) and not o do
    begin
      for i:= 1 to 8 do
        c[i]:=a[l1].c[8-i+1];
      search1(l1,r1,'A');
      if o then break;
      c[1]:=a[l1].c[4]; for i:= 1 to 3 do c[i+1]:=a[l1].c[i];
      c[8]:=a[l1].c[5]; for i:= 6 to 8 do c[i-1]:=a[l1].c[i];
      search1(l1,r1,'B');
      if o then break;
      c[1]:=a[l1].c[1]; c[4]:=a[l1].c[4]; c[5]:=a[l1].c[5]; c[8]:=a[l1].c[8];
      c[2]:=a[l1].c[7]; c[3]:=a[l1].c[2]; c[6]:=a[l1].c[3]; c[7]:=a[l1].c[6];
      search1(l1,r1,'C');
      if o then break;
      inc(l1);
    end;
  if not o then
    begin
      l2:=1; r2:=1; o:=false;
      while (l2<=r2) and not o do
        begin
          for i:= 1 to 8 do
            c[i]:=b[l2].c[8-i+1];
          search2(l2,r2,'A');
          if o then break;
          c[4]:=b[l2].c[1]; for i:= 1 to 3 do c[i]:=b[l2].c[i+1];
          c[5]:=b[l2].c[8]; for i:= 6 to 8 do c[i]:=b[l2].c[i-1];
          search2(l2,r2,'B');
          if o then break;
          c[1]:=b[l2].c[1]; c[4]:=b[l2].c[4]; c[5]:=b[l2].c[5]; c[8]:=b[l2].c[8];
          c[2]:=b[l2].c[3]; c[3]:=b[l2].c[6]; c[6]:=b[l2].c[7]; c[7]:=b[l2].c[2];
          search2(l2,r2,'C');
          if o then break;
          inc(l2);
        end;
      writeln(a[kk].time+b[r2].time);
      print1(kk);
      print2(r2);
    end
  else
    begin
      writeln(a[r1].time);
      print1(r1);
    end;
  writeln;
  close(input);
  close(output);
end.
