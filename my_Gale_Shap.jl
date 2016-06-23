function my_Gale_Shap{T<:Int64}(prop_prefs::AbstractArray{T, 2}, resp_prefs::AbstractArray{T, 2}, caps=ones(Int64, size(resp_prefs, 2)))
    m = size(prop_prefs, 2)
    n = size(resp_prefs, 2)
    L = sum(caps)
    prop_matched = zeros(Int64, m)
    resp_matched = zeros(Int64, L)
    prop_pool = collect(1:m)
    
    println(prop_matched, resp_matched, prop_pool, caps, 1)
    
    while length(prop_pool) != 0
        i = pop!(prop_pool)
        
        for j in prop_prefs[:, i]
            
            if j == 0
                prop_matched[i] = 0
                break
                
                println(prop_matched, resp_matched, prop_pool, 2)
                
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
                            
                            println(prop_matched, resp_matched, prop_pool, 3)
                            
                        else
                            push!(prop_pool, resp_matched[t])
                            resp_matched[t] = i
                            prop_matched[i] = j
                            count = 1
                            break
                            
                            println(prop_matched, resp_matched, prop_pool, 4)
                            
                        end
                    else
                        resp_matched[t] = resp_matched[t]
                        prop_matched[i] = prop_matched[i]
                    end
                    
                    println(prop_matched, resp_matched, prop_pool, 5)
                    
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
                            
                            println(prop_matched, resp_matched, prop_pool, 6)
                            
                        else
                            push!(prop_pool, resp_matched[t])
                            resp_matched[t] = i
                            prop_matched[i] = j
                            count = 1
                            break
                            
                            println(prop_matched, resp_matched, prop_pool, 7)
                            
                        end
                    else
                        resp_matched[t] = resp_matched[t]
                        prop_matched[i] = prop_matched[i]
                    end
                    
                    println(prop_matched, resp_matched, prop_pool, 8)
                    
                end
                if count == 1
                    break
                end
            end
        end
        
        println(prop_matched, resp_matched, prop_pool, 9)
        
    end
    return prop_matched, resp_matched
end