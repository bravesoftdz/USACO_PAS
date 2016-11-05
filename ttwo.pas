{
ID:kjinxin1
PROG:ttwo
LANG:PASCAL
}
type
  node=record
    x,y:longint;
    dir:longint;
  end;
var
  g:array[-2..12,-2..12] of char;
  ch:char;
  hash1,hash2:array[0..10,0..10,0..4] of boolean;
  top,x1,x2,y1,y2,i,j:longint;

procedure search(x01,y01,dir01,x02,y02,dir02,time:longint);
var
  i,j,x1,y1,dir1,dir2,x2,y2:longint;
begin
  if time>1000 then
    begin
      writeln('0');
      exit;
    end;
  case dir01 of
    1:begin
        x1:=x01; y1:=y01+1; dir1:=dir01;
        if g[x1,y1]='*' then
          begin
            x1:=x01; y1:=y01; dir1:=3;
          end;
      end;
    2:begin
        x1:=x01; y1:=y01-1; dir1:=dir01;
        if g[x1,y1]='*' then
          begin
            x1:=x01; y1:=y01; dir1:=4;
          end;
      end;
    3:begin
        x1:=x01+1; y1:=y01; dir1:=dir01;
        if g[x1,y1]='*' then
          begin
            x1:=x01; y1:=y01; dir1:=2;
          end;
      end;
    4:begin
        x1:=x01-1; y1:=y01; dir1:=dir01;
        if g[x1,y1]='*' then
          begin
            x1:=x01; y1:=y01; dir1:=1;
          end;
      end;
  end;
  case dir02 of
    1:begin
        x2:=x02; y2:=y02+1; dir2:=dir02;
        if g[x2,y2]='*' then
          begin
            x2:=x02; y2:=y02; dir2:=3;
          end;
      end;
    2:begin
        x2:=x02; y2:=y02-1; dir2:=dir02;
        if g[x2,y2]='*' then
          begin
            x2:=x02; y2:=y02; dir2:=4;
          end;
      end;
    3:begin
        x2:=x02+1; y2:=y02; dir2:=dir02;
        if g[x2,y2]='*' then
          begin
            x2:=x02; y2:=y02; dir2:=2;
          end;
      end;
    4:begin
        x2:=x02-1; y2:=y02; dir2:=dir02;
        if g[x2,y2]='*' then
          begin
            x2:=x02; y2:=y02; dir2:=1;
          end;
      end;
  end;
  if (x1=x2) and (y1=y2) then
    begin
      writeln(time);
      exit;
    end
  else
    begin
      inc(time);
      search(x1,y1,dir1,x2,y2,dir2,time);
    end;
end;
begin
  assign(input,'ttwo.in');
  reset(input);
  assign(output,'ttwo.out');
  rewrite(output);
  fillchar(hash1,sizeof(hash1),0);
  fillchar(hash2,sizeof(hash2),0);
  for i:= -2 to 12 do
    for j:= -2 to 12 do
      g[i,j]:='*';
  for i:= 1 to 10 do
    begin
      for j:= 1 to 10 do
        begin
          read(g[i,j]);
          if g[i,j]='F' then
            begin
              x1:=i; y1:=j;
            end;
          if g[i,j]='C' then
            begin
              x2:=i; y2:=j;
            end;
        end;
      readln;
    end;
  hash1[x1,y1,4]:=true; hash2[x2,y2,4]:=true;
  search(x1,y1,4,x2,y2,4,1);
  close(input); close(output);
end.