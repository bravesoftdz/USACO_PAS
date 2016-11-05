{
ID:kjinxin1
PROG:packrec
LANG:PASCAL
}
type
  node=record
    x,y:longint;
  end;
  node1=record
    x,y,s:longint;
  end;
var
  g:array[1..4] of node;
  ans:array[1..20] of node1;
  hash:array[0..200,0..200] of integer;
  i,j,k,l,top,t,t1,t2,t3,t4:longint;
function max(m,n:longint):longint;
begin
  if m>n then exit(m)
  else exit(n);
end;
procedure paixu(m,n:longint);
var
  l1,l2,x:longint;
  t:node1;
begin
  l1:=m; l2:=n; x:=ans[(l1+l2) shr 1].x;
  repeat
    while ans[l1].x<x do inc(l1);
    while ans[l2].x>x do dec(l2);
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
procedure change(var x,y:longint);
var
  t:longint;
begin
  t:=x; x:=y; y:=t;
end;

procedure search(p,q:longint);
begin
  if p*q>ans[top].s then exit;
  if (hash[p,q]=0) then
    begin
      hash[p,q]:=1; hash[q,p]:=1;
      if p*q<ans[top].s then
        top:=1
      else inc(top);
      ans[top].s:=p*q; ans[top].x:=p; ans[top].y:=q;
    end;
end;
procedure try1(i,j,k,l:longint);
var
  t,p,q:longint;
begin
  p:=(g[i].x+g[j].x+g[k].x+g[l].x);
  q:=max(g[i].y,g[j].y);
  q:=max(q,g[l].y);
  q:=max(q,g[k].y);
  if top=0 then
    begin
      hash[p,q]:=1; hash[q,p]:=1;
      inc(top);
      ans[top].s:=p*q; ans[top].x:=p; ans[top].y:=q;
    end
  else search(p,q);
end;
procedure try2(i,j,k,l:longint);
var
  p,q:longint;
begin
  p:=max(g[i].x,g[j].x+g[k].x+g[l].x);
  q:=max(g[j].y,g[k].y);
  q:=max(q,g[l].y);
  inc(q,g[i].y);
  search(p,q);
end;
procedure try3(i,j,k,l:longint);
var
  p,q:longint;
begin
  p:=max(g[i].x+g[j].x,g[j].x+g[k].x+g[l].x);
  q:=max(g[i].y+g[k].y,g[i].y+g[l].y);
  q:=max(q,g[j].y);
  search(p,q);
end;
procedure try4(i,j,k,l:longint);
var
  p,q:longint;
begin
  p:=g[i].x+max(g[j].x,g[k].x)+g[l].x;
  q:=max(g[i].y,g[l].y);
  q:=max(q,g[j].y+g[k].y);
  search(p,q);
end;
procedure try5(i,j,k,l:longint);
var
  p,q:longint;
begin
  if g[i].y+g[j].y<=g[l].y then
    begin
      p:=max(g[i].x+g[l].x,g[j].x+g[l].x);
      p:=max(p,g[k].x);
      q:=g[k].y+g[l].y;
    end
  else
  if g[l].y>=g[i].y then
    begin
      p:=max(g[i].x+g[l].x,g[j].x+g[l].x);
      p:=max(p,g[j].x+g[k].x);
      q:=max(g[i].y+g[j].y,g[l].y+g[k].y);
    end;
  search(p,q);
end;

begin
  assign(input,'packrec.in');
  reset(input);
  assign(output,'packrec.out');
  rewrite(output);
  top:=0;
  fillchar(g,sizeof(g),0);
  fillchar(ans,sizeof(ans),0);
  fillchar(hash,sizeof(hash),0);
  for i:= 1 to 4 do
    begin
      readln(g[i].x,g[i].y);
      if g[i].x>g[i].y then change(g[i].x,g[i].y);
    end;
  for t:= 1 to 5 do
  for i:= 4 downto 1 do
    for j:= 4 downto 1 do
      if i<>j then
        for k:= 4 downto 1 do
          if (i<>k) and (j<>k) then
            for l:= 4 downto 1 do
              if (l<>i) and (j<>l) and (l<>k) then
                begin
                  for t1:= 1 to 2 do
                    begin
                      if t1=2 then
                        change(g[i].x,g[i].y);
                      for t2:= 1 to 2 do
                        begin
                          if t2=2 then
                            change(g[j].x,g[j].y);
                          for t3:= 1 to 2 do
                            begin
                              if t3=2 then
                                change(g[k].x,g[k].y);
                              for t4:= 1 to 2 do
                                begin
                                  if t4=2 then change(g[l].x,g[l].y);
                                  case t of
                                    1:try1(i,j,k,l);
                                    2:try2(i,j,k,l);
                                    3:try3(i,j,k,l);
                                    4:try4(i,j,k,l);
                                    5:try5(i,j,k,l);
                                  end;
                                  if t4=2 then change(g[l].x,g[l].y);
                                end;
                              if t3=2 then change(g[k].x,g[k].y)
                            end;
                          if t2=2 then change(g[j].x,g[j].y);
                        end;
                      if t1=2 then change(g[i].x,g[i].y);
                    end;
                end;
  for i:= 1 to top do
    begin
      if ans[i].x>ans[i].y then change(ans[i].x,ans[i].y);
    end;
  paixu(1,top);
  writeln(ans[1].s);
  for i:= 1 to top do
    begin
      writeln(ans[i].x,' ',ans[i].y);
    end;
  close(input);
  close(output);
end.