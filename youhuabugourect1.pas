{
ID:kjinxin1
PROG:rect1
LANG:PASCAL
}
type
  node=record
    l1,l2,r1,r2,color,pos:longint;
  end;
  node1=record
    l,r:longint;
  end;
var
  g:array[0..1050] of node;
  f:array[0..2010,0..2010] of longint;
  hashl,hashr:array[0..10010] of longint;
  hash:array[0..2510] of longint;
  dx,dy:array[0..2000] of node1;
  i,j,k,a,b,n,l,r,sum:longint;
  o:boolean;
begin
  assign(input,'rect1.in');
  reset(input);
  assign(output,'rect1.out');
  rewrite(output);
  fillchar(hash,sizeof(hash),0);
  fillchar(g,sizeof(g),0);
  fillchar(f,sizeof(f),0);
  fillchar(hashl,sizeof(hashl),0);
  fillchar(hashr,sizeof(hashr),0);
  fillchar(dx,sizeof(dx),0);
  fillchar(dy,sizeof(dy),0);
  readln(a,b,n);
  for i:= 1 to n do
    begin
      with g[i] do
        begin
          readln(l1,r1,l2,r2,color);
          hashl[l1]:=1; hashl[l2]:=1;
          hashr[r1]:=1; hashr[r2]:=1;
          pos:=i;
        end;
    end;
  l:=0;
  for i:= 0 to 10000 do
    begin
      if hashl[i]=1 then
        begin
          inc(l); hashl[i]:=l;
          dx[l].l:=i;
          dx[l-1].r:=i;
        end;
    end;
  r:=0;
  for i:= 0 to 10000 do
    begin
      if hashr[i]=1 then
        begin
          inc(r); hashr[i]:=r;
          dy[r].l:=i;
          dy[r-1].r:=i;
        end;
    end;
  for i:= 1 to n do
    begin
      for j:= hashl[g[i].l1] to hashl[g[i].l2]-1 do
        for k:= hashr[g[i].r1] to hashr[g[i].r2]-1 do
          begin
            f[j,k]:=g[i].color;
          end;
    end;
  for i:= 1 to l-1 do
    for j:= 1 to r-1  do
      begin
        hash[f[i,j]]:=hash[f[i,j]]+(dx[i].r-dx[i].l)*(dy[j].r-dy[j].l);
      end;
  sum:=0;
  for i:= 1 to 2500 do
    begin
      inc(sum,hash[i]);
    end;
  sum:=a*b-sum;
  inc(hash[1],sum);
  for i:= 1 to 2500 do
    begin
      if hash[i]<>0 then
        begin
          writeln(i,' ',hash[i]);
        end;
    end;
  close(input); close(output);
end.
