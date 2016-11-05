{
ID:kjinxin1
PROG:butter
LANG:PASCAL
}
type
  node=record
    x,y,data:longint;
  end;
  node1=record
    st,fi:longint;
  end;
  node2=record
    data,pos:longint;
  end;
var
  g:array[0..10000] of node;
  xin:array[0..1000] of node1;
  hash,a:array[0..1000] of longint;
  dui:array[0..20000] of node2;
  hash1:array[0..1000] of boolean;
  ans,i,j,c,p,n,top:longint;
procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:node;
begin
  l1:=m; l2:=n; x:=g[(l1+l2) shr 1].x;
  repeat
    while g[l1].x<x do inc(l1);
    while g[l2].x>x do dec(l2);
    if l1<=l2 then
      begin
        t:=g[l1]; g[l1]:=g[l2]; g[l2]:=t;
        inc(l1); dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if l2>m then paixu(m,l2);
end;

procedure jian(t:longint);
var
  i,j:longint;
  o:boolean;
  h:node2;
begin
  j:=t; o:=true;
  while (j>1) and o do
    begin
      i:=j;
      j:=j shr 1;
      if dui[j].data>dui[i].data then
        begin
          h:=dui[j]; dui[j]:=dui[i]; dui[i]:=h;
        end
      else o:=false;
    end;
end;
procedure heap(t:longint);
var
  l,r,large:longint;
  o:boolean;
  h:node2;
begin
  o:=true;
  while o do
    begin
      large:=t;
      if (t*2<=top) and (dui[t*2].data<dui[large].data) then large:=t*2;
      if (t*2+1<=top) and (dui[t*2+1].data<dui[large].data) then large:=t*2+1;
      if large=t then
        o:=false
      else
        begin
          h:=dui[t]; dui[t]:=dui[large]; dui[large]:=h;
          t:=large;
        end;
    end;
end;
procedure main(t:longint);
var
  i,j,k,q,data:longint;
  o:boolean;
begin
  fillchar(hash1,sizeof(hash1),0);
  fillchar(dui,sizeof(dui),0);
  fillchar(a,sizeof(a),$ff);
  hash1[t]:=true; top:=0;
  for i:= xin[t].st to xin[t].fi do
    begin
      a[g[i].y]:=g[i].data;
      inc(top);
      dui[top].pos:=g[i].y;
      dui[top].data:=g[i].data;
      jian(top);
    end;
  a[t]:=0;
  for i:= 1 to p-2 do
    begin
      o:=false;
      while not o do
        begin
          j:=dui[1].pos;
          dui[1]:=dui[top]; dec(top);
          heap(1);
          if not hash1[j] then
            begin
              o:=true;
            end;
        end;
      hash1[j]:=true;
      for k:= xin[j].st to xin[j].fi do
        begin
          if (a[g[k].y]=-1) or (a[g[k].y]<>-1) and (a[j]+g[k].data<a[g[k].y]) then
            begin
              a[g[k].y]:=a[j]+g[k].data;
              inc(top);
              dui[top].data:=a[g[k].y]; dui[top].pos:=g[k].y;
              jian(top);
            end;
        end;
    end;
  q:=0;
  for i:= 1 to p do
    begin
      q:=a[i]*hash[i]+q;
    end;
  if q<ans then ans:=q;
end;
begin
  assign(input,'butter.in');
  reset(input);
  assign(output,'butter.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(xin,sizeof(xin),0);
  fillchar(hash,sizeof(hash),0);
  readln(n,p,c); ans:=maxlongint;
  for i:= 1 to n do
    begin
      readln(j); inc(hash[j]);
    end;
  for i:= 1 to c do
    begin
      readln(g[i].x,g[i].y,g[i].data);
      g[i+c].x:=g[i].y; g[i+c].y:=g[i].x; g[i+c].data:=g[i].data;
    end;
  paixu(1,c*2);
  for i:= 1 to 2*c do
    begin
      if g[i].x<>g[i-1].x then
        begin
          xin[g[i-1].x].fi:=i-1;
          xin[g[i].x].st:=i;
        end;
    end;
  xin[g[c*2].x].fi:=2*c;
  for i:= 1 to p do
    begin
      main(i);
    end;
  writeln(ans);
  close(input); close(output);
end.