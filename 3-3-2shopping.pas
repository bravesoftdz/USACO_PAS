{
ID:kjinxin1
PROG:shopping
LANG:PASCAL
}
type
  node1=record
    c,k:longint;
  end;
  node=record
    n,p:longint;
    a:array[1..5] of node1
  end;
var
  g:array[0..100] of node;
  data:node;
  value:array[1..5] of longint;
  f:array[0..5,0..5,0..5,0..5,0..5] of longint;
  hash:array[0..1000] of integer;
  s,i,j,k,l,q,p:longint;
  t:node1;
function search(i,j,k,p,q:longint):longint;
var
  l,u,i1,j1,k1,q1,p1:longint;
  o:boolean;
begin
  if f[i,j,k,p,q]<>-1 then exit(f[i,j,k,p,q]);
  for l:= 1 to s do
    begin
      o:=true; i1:=0; j1:=0; k1:=0; p1:=0; q1:=0;
      for u:= 1 to g[l].n do
        begin
          if hash[g[l].a[u].c]<>0 then
            begin
              case hash[g[l].a[u].c] of
                1:i1:=g[l].a[u].k;
                2:j1:=g[l].a[u].k;
                3:k1:=g[l].a[u].k;
                4:p1:=g[l].a[u].k;
                5:q1:=g[l].a[u].k;
              end;
            end
          else
            begin
              o:=false;
              break;
            end;
        end;
      if o then
      if (i-i1>=0) and (j-j1>=0) and (k-k1>=0) and (p-p1>=0) and (q-q1>=0) then
        begin
          if f[i-i1,j-j1,k-k1,p-p1,q-q1]=-1 then
             f[i-i1,j-j1,k-k1,p-p1,q-q1]:=search(i-i1,j-j1,k-k1,p-p1,q-q1);
          if f[i,j,k,p,q]=-1 then
            f[i,j,k,p,q]:=f[i-i1,j-j1,k-k1,p-p1,q-q1]+g[l].p
          else
          if f[i,j,k,p,q]>f[i-i1,j-j1,k-k1,p-p1,q-q1]+g[l].p then
            f[i,j,k,p,q]:=f[i-i1,j-j1,k-k1,p-p1,q-q1]+g[l].p;
        end;
    end;
  if f[i,j,k,p,q]=-1 then
    begin
      f[i,j,k,p,q]:=i*value[1]+j*value[2]+k*value[3]+p*value[4]+q*value[5];
    end;
  exit(f[i,j,k,p,q]);
end;
begin
  assign(input,'shopping.in'); reset(input);
  assign(output,'shopping.out'); rewrite(output);
  fillchar(g,sizeof(g),0);
  fillchar(data,sizeof(data),0);
  fillchar(value,sizeof(value),0);
  fillchar(f,sizeof(f),$ff);
  fillchar(hash,sizeof(hash),0);
  readln(s);
  for i:= 1 to s do
    begin
      read(g[i].n);
      for j:= 1 to g[i].n do
        begin
          read(g[i].a[j].c,g[i].a[j].k);
        end;
      readln(g[i].p);
    end;
  readln(data.n);
  for i:= 1 to data.n do
    begin
      readln(data.a[i].c,data.a[i].k,value[i]);
    end;
  for p:= 1 to data.n-1 do
    for q:= p+1 to data.n do
      begin
        if data.a[p].c>data.a[q].c then
          begin
            t:=data.a[p]; data.a[p]:=data.a[q]; data.a[q]:=t;
            j:=value[p]; value[p]:=value[q]; value[q]:=j;
          end;
      end;
  for i:= 1 to data.n do
    begin
      hash[data.a[i].c]:=i;
    end;
  i:=0; j:=0; p:=0; k:=0; q:=0;
  for l:= 1 to data.n do
    begin
      case hash[data.a[l].c] of
        1:i:=data.a[l].k;
        2:j:=data.a[l].k;
        3:k:=data.a[l].k;
        4:p:=data.a[l].k;
        5:q:=data.a[l].k;
      end;
    end;
  f[i,j,k,p,q]:=search(i,j,k,p,q);
  writeln(f[i,j,k,p,q]);
  close(input); close(output);
end.
