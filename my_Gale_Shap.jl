function my_Gale_Shap(prop_prefs::Matrix{Int}, resp_prefs::Matrix{Int}, caps=ones(Int64, size(resp_prefs, 2)))
    m = size(prop_prefs, 2)
    n = size(resp_prefs, 2)
    L = sum(caps)
    prop_matched = zeros(Int64, m)
    resp_matched = zeros(Int64, L)
    prop_pool = collect(1:m)
    
    while length(prop_pool) != 0
        i = pop!(prop_pool)
        
        for j in prop_prefs[:, i]
            
            if j == 0
                prop_matched[i] = 0
                break
                
                
                elseif j == 1
                count = 0
                k = 1
                l = caps[1]
                
                for t in k:l
                    if findnext(resp_prefs[:, j], resp_matched[t], 1) > findnext(resp_prefs[:, j], i, 1)
                        if resp_matched[t] == 0
                            resp_matched[t] = i
                            prop_matched[i] = j
                            count = 1
                            break
                            
                           
                        else
                            push!(prop_pool, resp_matched[t])
                            resp_matched[t] = i
                            prop_matched[i] = j
                            count = 1
                            break
                            
                            
                        end
                    else
                        resp_matched[t] = resp_matched[t]
                        prop_matched[i] = prop_matched[i]
                    end
                    
                   
                end
                if count == 1
                    break
                end
                
            else
                count = 0
                k = sum(caps[1:j-1]) + 1
                l = sum(caps[1:j])
                for t in k:l
                    if findnext(resp_prefs[:, j], resp_matched[t], 1) > findnext(resp_prefs[:, j], i, 1)
                        if resp_matched[t] == 0
                            resp_matched[t] = i
                            prop_matched[i] = j
                            count = 1
                            break
                            
                            
                        else
                            push!(prop_pool, resp_matched[t])
                            resp_matched[t] = i
                            prop_matched[i] = j
                            count = 1
                            break
                            
                            
                        end
                    else
                        resp_matched[t] = resp_matched[t]
                        prop_matched[i] = prop_matched[i]
                    end
                    
                   
                end
                if count == 1
                    break
                end
            end
        end
        
       
    end
    return prop_matched, resp_matched
end