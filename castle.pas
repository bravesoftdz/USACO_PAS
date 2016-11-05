{
ID:kjinxin1
PROG:castle
LANG:PASCAL
}
{
E:1; W:2; S:3; N:4;
}
type
  node=record
    x,y:longint;
  end;
  node1=record
    fi,st:longint;
  end;
var
  n,m:longint;
  g:array[0..50,0..50] of longint;
  chess:array[0..10000] of node;
  jx:array[0..2500] of node;
  xin:array[0..2500] of node1;
  color:array[0..2500] of boolean;
  hash,hash1:array[0..2500] of longint;
  ans,i,j,top,sum:longint;
procedure put(x,y,pos,t:longint);
var
  i,j:longint;
begin
  case t of
      1:begin
          if y<m then
            begin
              inc(top);
              chess[top].x:=pos;
              chess[top].y:=pos+n;
            end;
        end;
      2:begin
          if y>1 then
            begin
              inc(top);
              chess[top].x:=pos;
              chess[top].y:=pos-n;
            end;
        end;
      3:begin
          if x<n then
            begin
              inc(top);
              chess[top].x:=pos;
              chess[top].y:=pos-1;
            end;
        end;
      4:begin
          if x>1 then
            begin
              inc(top);
              chess[top].x:=pos;
              chess[top].y:=pos+1;
            end;
        end;
    end;
end;
procedure try1(x,y,pos,data:longint);
var
  i,j:longint;
begin
  jx[pos].x:=x; jx[pos].y:=y;
  case data of
      0:begin
          put(x,y,pos,1); put(x,y,pos,2); put(x,y,pos,3); put(x,y,pos,4);
        end;
      1:begin
          put(x,y,pos,1); put(x,y,pos,3); put(x,y,pos,4);
        end;
      2:begin
          put(x,y,pos,1); put(x,y,pos,2); put(x,y,pos,3);
        end;
      4:begin
          put(x,y,pos,2); put(x,y,pos,3); put(x,y,pos,4);
        end;
      8:begin
          put(x,y,pos,1); put(x,y,pos,2); put(x,y,pos,4);
        end;
      3:begin
          put(x,y,pos,1); put(x,y,pos,3);
        end;
      5:begin
          put(x,y,pos,3); put(x,y,pos,4);
        end;
      9:begin
          put(x,y,pos,1); put(x,y,pos,4);
        end;
      6:begin
          put(x,y,pos,2); put(x,y,pos,3);
        end;
      10:begin
          put(x,y,pos,1); put(x,y,pos,2);
         end;
      12:begin
          put(x,y,pos,2); put(x,y,pos,4);
         end;
      7:begin
          put(x,y,pos,3);
        end;
      11:begin
          put(x,y,pos,1);
         end;
      13:begin
           put(x,y,pos,4);
         end;
      14:begin
           put(x,y,pos,2);
         end;
    end;
end;
procedure dfsvisit(t:longint);
var
  i,j:longint;
begin
  color[t]:=true;
  hash[t]:=sum;
  if xin[t].st<>0 then
  for i:= xin[t].st to xin[t].fi do
    begin
      j:=chess[i].y;
      if not color[j] then
        begin
          dfsvisit(j);
        end;
    end;
end;
procedure dfs;
var
  i,j:longint;
begin
  fillchar(color,sizeof(color),0);
  for i:= 1 to n*m do
    begin
      if not color[i] then
        begin
          inc(sum);
          dfsvisit(i);
        end;
    end;
end;
procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:node;
begin
  l1:=m; l2:=n; x:=chess[(l1+l2) shr 1].x;
  repeat
    while chess[l1].x<x do inc(l1);
    while chess[l2].x>x do dec(l2);
    if l1<=l2 then
      begin
        t:=chess[l1];
        chess[l1]:=chess[l2];
        chess[l2]:=t;
        inc(l1);
        dec(l2);
      end;
  until l1>l2;
  if l1<n then paixu(l1,n);
  if m<l2 then paixu(m,l2);
end;
procedure search;
var
  i,j:longint;
  t:node;
  ch:char;
begin
  for i:= 1 to n*m do
    begin
      if (jx[i].x>1) and (hash[i+1]<>hash[i]) and (hash1[hash[i+1]]+hash1[hash[i]]>ans) then
        begin
          ans:=hash1[hash[i+1]]+hash1[hash[i]];
          t:=jx[i]; ch:='N';
        end;
      if (jx[i].y<m) and (hash[i+n]<>hash[i]) and (hash1[hash[i+n]]+hash1[hash[i]]>ans) then
        begin
          ans:=hash1[hash[i+n]]+hash1[hash[i]];
          t:=jx[i]; ch:='E';
        end;
      if (jx[i].x>1) and (hash[i+1]<>hash[i]) and (hash1[hash[i+1]]+hash1[hash[i]]=ans) and (ch='E') and (t.y=jx[i].y) then
        begin
          t:=jx[i]; ch:='N';
        end;
    end;
  writeln(ans);
  writeln(t.x,' ',t.y,' ',ch);
end;
begin
  assign(input,'castle.in');
  reset(input);
  assign(output,'castle.out');
  rewrite(output);
  readln(m,n);
  fillchar(g,sizeof(g),0);
  fillchar(chess,sizeof(chess),0);
  top:=0; sum:=0;
  for i:= 1 to n do
    begin
      for j:= 1 to m do
        begin
          read(g[i,j]);
          try1(i,j,(j-1)*n+(n-i+1),g[i,j])
        end;
      readln;
    end;
  paixu(1,top);
  for i:= 1 to top do
    begin
      if chess[i].x<>chess[i-1].x then
        begin
          xin[chess[i-1].x].fi:=i-1;
          xin[chess[i].x].st:=i;
        end;
    end;
  xin[chess[top].x].fi:=top;
  dfs;
  for i:= 1 to n*m do
    begin
      inc(hash1[hash[i]]);
    end;
  writeln(sum); j:=-maxlongint;
  for i:= 1 to sum do
    begin
      if hash1[i]>j then j:=hash1[i];
    end;
  writeln(j);
  ans:=j;
  search;
  close(input); close(output);
end.
