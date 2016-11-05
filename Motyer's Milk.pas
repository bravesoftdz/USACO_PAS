{
ID:kjinxin1
PROG:milk3
LANG:PASCAL
}
const
  p1=9911; p2=4131; p3=5933; p4=9971;
type
  node=record
    a,b,c:longint;
  end;
var
  ans:array[0..800] of node;
  h:array[0..800] of longint;
  hash:array[0..10000] of longint;
  a,b,c,i,j,num:longint;
function max(m,n:longint):longint;
begin
  if m>n then exit(m)
  else exit(n);
end;
function min(m,n:longint):longint;
begin
  if m<n then exit(m)
  else exit(n);
end;
procedure build;
var
  i,j:longint;
begin
  j:=(ans[num].a*p1+ans[num].b*p2+ans[num].c*p3) div p4;
  while hash[j]<>0 do
    begin
      inc(j);
      if j=p4 then j:= j mod p4;
    end;
  hash[j]:=num;
end;
function judge(a,b,c:longint):boolean;
var
  i,j:longint;
  o:boolean;
begin
  j:=(a*p1+b*p2+c*p3) div p4;
  o:=true;
  while (hash[j]<>0) and o do
    begin
      i:=hash[j];
      if (a=ans[i].a) and (b=ans[i].b) and (c=ans[i].c) then
        o:=false
      else inc(j);
      if j=p4 then j:= j mod p4;
    end;
  judge:=o;
end;
procedure try1(a2,b2,c2:longint);
forward;
procedure search(a1,b1,c1:longint);
var
  i,j,a2,b2,c2:longint;
begin
  if a1>0 then
    begin
      if b1<>b then
        begin
          a2:=max(0,a1-(b-b1));
          b2:=min(b,b1+a1);
          c2:=c1;
          try1(a2,b2,c2);
        end;
      if c1<>c then
        begin
          a2:=max(0,a1-(c-c1));
          b2:=b1;
          c2:=min(c,c1+a1);
          try1(a2,b2,c2);
        end;
    end;
  if b1>0 then
    begin
       if a1<>a then
         begin
           a2:=min(a,a1+b1);
           b2:=max(0,b1-(a-a1));
           c2:=c1;
           try1(a2,b2,c2);
         end;
       if c1<>c then
         begin
           a2:=a1;
           b2:=max(0,b1-(c-c1));
           c2:=min(c,c1+b1);
           try1(a2,b2,c2);
         end;
    end;
  if c1>0 then
    begin
       if a1<>a then
         begin
           a2:=min(a,a1+c1);
           b2:=b1;
           c2:=max(0,c1-(a-a1));
           try1(a2,b2,c2);
         end;
       if b1<>b then
         begin
           a2:=a1;
           b2:=min(b,b1+c1);
           c2:=max(0,c1-(b-b1));
           try1(a2,b2,c2);
         end;
    end;
end;
procedure try1(a2,b2,c2:longint);
begin
  if judge(a2,b2,c2) then
    begin
      inc(num);
      ans[num].a:=a2; ans[num].b:=b2; ans[num].c:=c2;
      build;
      search(a2,b2,c2);
    end;
end;
procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:node;
begin
  l1:=m; l2:=n; x:=ans[(l1+l2) shr 1].c;
  repeat
    while ans[l1].c<x do inc(l1);
    while ans[l2].c>x do dec(l2);
    if l1<=l2 then
      begin
        t:=ans[l1];
        ans[l1]:=ans[l2];
        ans[l2]:=t;
        inc(l1);
        dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if l2>m then paixu(m,l2);
end;
begin
  assign(input,'milk3.in');
  reset(input);
  assign(output,'milk3.out');
  rewrite(output);
  fillchar(ans,sizeof(ans),0);
  fillchar(hash,sizeof(hash),0);
  readln(a,b,c);
  num:=1;
  ans[num].a:=0; ans[num].b:=0; ans[num].c:=c;
  build;
  search(0,0,c);
  paixu(1,num);              j:=0;
  for i:= 1 to num do
    begin
      if ans[i].a=0 then
        begin
          inc(j);
          h[j]:=ans[i].c;
        end;
    end;
  for i:= 1 to j-1 do
    write(h[i],' ');
  writeln(h[j]);
  close(input);
  close(output);
end.
