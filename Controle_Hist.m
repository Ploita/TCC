%%
% 
% p_temp = sym('p',[1 M]);
% A = sym('y',[1 3]);
% A(2) = sym('u1');
% A(3) = sym('e1');
% 
% for i = 1
%     pos = 1;
%     for j =1:ny
%         p_temp(i,pos) = A(1);
%     end
%         pos = pos+1;
% 
%     for j =1:nu
%         p_temp(i,pos) = A(2);
%     end
%         pos = pos+1;
%         
%     for j =1:ne
%         p_temp(i,pos) = A(3);    
%     end
%         pos = pos+1;
%     
%     %Matriz de regressão (2ª ordem)
%     if l>=2
%         for j = 1:n
%             for k = j:n 
%                 p_temp(i,pos) = p_temp(i,j)*p_temp(i,k);
%                 pos = pos +1;
%             end
%         end
%     end
%     
%     %Matriz de regressão (3ª ordem)
%     if l >=3
%        for j =1:n
%             for k = j:n
%                 for ll = k:n
%                     p_temp(i,pos) = p_temp(i,j)*p_temp(i,k)*p_temp(i,ll);
%                     pos = pos+1;
%                 end
%             end
%         end 
%     end 
% end
% 
% eqn_input = sym('a',[1 M_linha]);
% teta_input = zeros(M_linha,1);
% eqn_def = sym('a',[1 M_linha]);
% teta_def = zeros(M_linha,1);
% pos1 = 1; pos2 = 1;
% for i = 1:M_linha
%     if ismember(indice(i),idc)
%         eqn_input(pos1) = p_temp(indice(i));
%         teta_input(pos1) = teta(i);
%         pos1 = pos1 + 1;
%     else
%         eqn_def(pos2) = p_temp(indice(i));
%         teta_def(pos1) = teta(i);
%         pos2 = pos2 + 1;
%     end
% end
% 
% sinal_controle = zeros(N+1,1);
% for i = 1:N
%     if i == 1
%          S = solve(eqn_input*teta_input == v(i) - subs(eqn_def*teta_def,'y1',0));
%          sinal_controle(i) = S(1);
%     else
%          S  = solve(eqn_input*teta_input == v(i) - subs(eqn_def*teta_def,'y1',output(i-1)));
%          sinal_controle(i) = S(1);
%     end
% end


%%
% syms x;
% sz = size(idc);
% temp_controle;
% temp_entrada;
% for i=1:M_linha
%     for j = 1:sz(2)
%         if idc(j) == indice(i)
%             if idc(j) <= ny + nu
%                 temp_entrada = x;
%             elseif idc(j) <= n + ny + nu
%                 temp_entrada = x*y;
%             temp_controle = temp_controle + temp_entrada*teta(i);
%             end
%         end
%     end
% end


