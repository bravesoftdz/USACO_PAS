{
ID:kjinxin1
PROG:humble
LANG:PASCAL
}
type
  node=record
    data:int64;
    pos:longint;
  end;
var
  l,r,mid,k,n,i,j,top:longint;
  g:array[0..100] of int64;
  s:array[0..200000] of node;
  o,hh:boolean;
  ans:int64;
procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:longint;
begin
  l1:=m; l2:=n; x:=g[(l1+l2) shr 1];
  repeat
    while g[l1]<x do inc(l1);
    while g[l2]>x do dec(l2);
    if l1<=l2 then
      begin
        t:=g[l1];
        g[l1]:=g[l2];
        g[l2]:=t;
        inc(l1);
        dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if l2>m then paixu(m,l2);
end;

procedure search(t:longint);
var
  i,j,k1,p:longint;
  u,vv:boolean;
  kl:int64;
begin
  u:=true;
  for i:= 1 to k do
    begin
      if g[i]<=t then
        begin
          inc(top);
          s[top].data:=g[i];
          s[top].pos:=i;
        end;
    end;
  l:=1;
  while u and (top<=n) do
    begin
      k1:=top;
      if s[l].data*g[1]>t then
        begin
          u:=false; break;
        end;
      for i:= l to top do
        begin
          if k1>n then break;
          for j:= s[i].pos to k do
            begin
              if s[i].data*g[j]<=t then
                begin
                  inc(k1);
                  s[k1].data:=s[i].data*g[j];
                  s[k1].pos:=j;
                end
              else break;
            end;
        end;
      l:=top+1;
      top:=k1;
    end;
  if u then
    begin
      o:=true;
    end;
  if not u and (top=n) then
    hh:=true;
end;
begin
  assign(input,'humble.in');
  reset(input);
  assign(output,'humble.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(s,sizeof(s),0);
  readln(k,n);
  for i:= 1 to k do
    begin
      read(g[i]);
    end;
  paixu(1,k);
  l:=1; r:=maxlongint;
  while l<r do
    begin
      mid:=l shr 1+r shr 1;
      top:=0;
      o:=false; hh:=false;
      search(mid);
      if hh then
        begin
          break;
        end;
      if o then
        begin
          r:=mid-1;
        end
      else
        begin
          l:=mid+1;
        end;
    end;
  ans:=0;
  if l=r then ans:=l
  else
  for i:= 1 to n do
    begin
      if s[i].data>ans then ans:=s[i].data;
    end;
  writeln(ans);
  close(input);
  close(output);
end.
