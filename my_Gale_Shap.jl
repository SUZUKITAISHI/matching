function my_Gale_Shap{T<:Int64}(prop_prefs::AbstractArray{T, 2}, resp_prefs::AbstractArray{T, 2}, caps::Vector{Int})
    m = size(prop_prefs, 2)
    n = size(resp_prefs, 2)
    L = sum(caps)
    prop_matched = zeros(Int64, m)
    resp_matched = zeros(Int64, L)
    prop_pool = collect(1:m)
    
    indptr = Array(Int, n+1)
    indptr[1] = 1
    for i in 1:n
        indptr[i+1] = indptr[i] + caps[i]
    end
    
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
    return prop_matched, resp_matched, indptr
end

function my_Gale_Shap{T<:Int64}(prop_prefs::AbstractArray{T, 2}, resp_prefs::AbstractArray{T, 2})
    caps = ones(Int, size(resp_prefs, 2))
    prop_matched, resp_matched, indptr = my_Gale_Shap(prop_prefs, resp_prefs, caps)
    return prop_matched, resp_matched
end