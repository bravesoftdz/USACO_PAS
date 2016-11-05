{
ID:kjinxin1
PROG:comehome
LANG:PASCAL
}
type
  node=record
    a,b:char;
    data:longint;
  end;
  node1=record
    st,fi:longint;
  end;
var
  g:array[0..20000] of node;
  xin:array[0..20000] of node1;
  a,b:array[0..100000] of longint;
  t1:array['A'..'Z'] of boolean;
  t2:array['a'..'z'] of boolean;
  n,i,ans,j,l,r,top,t:longint;
  ch,ch1,ch2:char;
procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:node;
begin
  l1:=m; l2:=n; x:=ord(g[l1].a);
  repeat
    while ord(g[l1].a)<x do inc(l1);
    while ord(g[l2].a)>x do dec(l2);
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
begin
  assign(input,'comehome.in');
  reset(input);
  assign(output,'comehome.out');
  rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(xin,sizeof(xin),0);
  fillchar(t1,sizeof(t1),0);
  fillchar(t2,sizeof(t2),0);
  fillchar(b,sizeof(b),0);
  for i:= 1 to ord('z') do
    b[i]:=maxlongint;
  readln(n);
  for i:= 1 to n do
    begin
      readln(g[i].a,ch1,g[i].b,ch2,g[i].data);
      if (ord(g[i].a)>ord('a')) and (ord(g[i].a)<ord('z')) then
        t2[g[i].a]:=true
      else t1[g[i].a]:=true;
      if (ord(g[i].b)>ord('a')) and (ord(g[i].b)<ord('z')) then
        t2[g[i].b]:=true
      else t1[g[i].b]:=true;
      g[n+i].a:=g[i].b; g[n+i].b:=g[i].a; g[n+i].data:=g[i].data;
    end;
  top:=0;
  for ch:= 'a' to 'z' do
    begin
      if t2[ch] then inc(top);
    end;
  for ch:= 'A' to 'Z' do
    begin
      if t1[ch] then inc(top);
    end;
  paixu(1,n*2);
  for i:= 1 to 2*n do
    begin
      if g[i].a<>g[i-1].a then
        begin
          xin[ord(g[i-1].a)].fi:=i-1;
          xin[ord(g[i].a)].st:=i;
        end;
    end;
  xin[ord(g[2*n].a)].fi:=2*n;
  l:=1; r:=1; a[l]:=ord('Z'); b[a[l]]:=0;
  while l<=r do
    begin
      for i:= xin[a[l]].st to xin[a[l]].fi do
        begin
          if b[a[l]]+g[i].data<b[ord(g[i].b)] then
            begin
              inc(r);
              a[r]:=ord(g[i].b);
              b[ord(g[i].b)]:=b[a[l]]+g[i].data;
            end;
        end;
      inc(l);
    end;
  ans:=maxlongint;
  for i:= 1 to ord('z') do
    begin
      if (b[i]<ans) and (b[i]>0) and (i<=ord('Z')) and (i>=ord('A')) then
        begin
          ans:=b[i];
          j:=i;
        end;
    end;
  writeln(chr(j),' ',ans);
  close(input); close(output);
end.