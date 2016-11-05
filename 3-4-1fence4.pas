{
ID:kjinxin1
PROG:fence4
LANG:PASCAL
}
type
  node=record
    x1,y1,x2,y2:longint;
  end;
var
  g:array[0..300] of node;
  ans:array[0..300] of longint;
  i,j,n,x,y,top:longint;
  o:boolean;
procedure init;
var
  i,j:longint;
  t:node;
begin
  fillchar(g,sizeof(g),0);
  readln(n);
  readln(x,y);
  for i:= 1 to n do
    begin
      readln(g[i].x1,g[i].y1);
    end;
  for i:= 1 to n-1 do
    begin
      g[i].x2:=g[i+1].x1; g[i].y2:=g[i+1].y1;
    end;
  g[n].x2:=g[n].x1; g[n].y2:=g[n].y1;
  g[n].x1:=g[1].x1; g[n].y1:=g[1].y1;
  t:=g[n]; g[n]:=g[n-1]; g[n-1]:=t;
end;
function try1(x1,y1,x2,y2,x,y:double):double;
begin
  try1:=(y-y1)*(x2-x1)+(x-x1)*(y1-y2);
end;
procedure judge;
var
  i,j:longint;
  data1,data2,data3,data4:double;
begin
  o:=true;
  for i:= 1 to n do
    begin
      if not o then break;
      for j:= 1 to n do
        begin
          if i<>j then
            begin
              data1:=try1(g[i].x1,g[i].y1,g[i].x2,g[i].y2,g[j].x1,g[j].y1);
              data2:=try1(g[i].x1,g[i].y1,g[i].x2,g[i].y2,g[j].x2,g[j].y2);
              data3:=try1(g[j].x1,g[j].y1,g[j].x2,g[j].y2,g[i].x1,g[i].y1);
              data4:=try1(g[j].x1,g[j].y1,g[j].x2,g[j].y2,g[i].x2,g[i].y2);
              if (data1*data2<0) and (data4*data3<0) then
                begin
                  o:=false; break;
                end;
            end;
        end;
    end;
end;
function try2(x1,y1,x2,y2,x:double):double;
begin
  try2:=(y2-y1)*(x-x1)/(x2-x1)+y1;
end;
procedure print;
var
  i,j:longint;
begin
  writeln(top);
  for i:= 1 to top do
    begin
      writeln(g[ans[i]].x1,' ',g[ans[i]].y1,' ',g[ans[i]].x2,' ',g[ans[i]].y2);
    end;
end;
procedure main;
var
  i,j,k:longint;
  l,data1,x2,y2,data2,data3,data4:double;
begin
  for i:= 1 to n do
    begin
      l:=(g[i].x2-g[i].x1)/200;
      for k:= 1 to 199 do
        begin
          o:=true;
          x2:=l*k+g[i].x1;
          if g[i].x1<>g[i].x2 then
            y2:=try2(g[i].x1,g[i].y1,g[i].x2,g[i].y2,x2)
          else y2:=(g[i].y2-g[i].y1)/199*k+g[i].y1;
          for j:= 1 to n do
            begin
              if i<>j then
                begin
                  data1:=try1(x,y,x2,y2,g[j].x1,g[j].y1);
                  data2:=try1(x,y,x2,y2,g[j].x2,g[j].y2);
                  data3:=try1(g[j].x1,g[j].y1,g[j].x2,g[j].y2,x,y);
                  data4:=try1(g[j].x1,g[j].y1,g[j].x2,g[j].y2,x2,y2);
                  if (data1*data2<=0) and (data3*data4<=0) then
                    begin
                      o:=false; break;
                    end;
                end;
            end;
          if o then
              break;
        end;
      if o then
        begin
          inc(top); ans[top]:=i;
        end;
    end;
  print;
end;
begin
  assign(input,'fence4.in'); reset(input);
  assign(output,'fence4.out'); rewrite(output);
  init;
  judge;
  if o then
    main
  else writeln('NOFENCE');
  close(input); close(output);
end.

