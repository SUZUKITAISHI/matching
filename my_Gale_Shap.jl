function my_Gale_Shap{T<:Int64}(m_prefs::AbstractArray{T, 2}, f_prefs::AbstractArray{T, 2})
    m = size(m_prefs, 2)
    n = size(f_prefs, 2)
    m_matched = zeros(Int64, m)
    f_matched = zeros(Int64, n)
    m_pool = collect(1:m)
    
    while length(m_pool) != 0
        i = pop!(m_pool)
        
        for j in m_prefs[:, i]
            
            if j == 0
                m_matched[i] = 0
                break
                
            else
                if findnext(f_prefs[:, j], f_matched[j], 1) > findnext(f_prefs[:, j], i, 1)
                    if f_matched[j] == 0
                        m_matched[i] = j
                        f_matched[j] = i
                        break
                        
                    else
                        push!(m_pool, f_matched[j])
                        m_matched[i] = j
                        f_matched[j] = i
                        break
                    end
                else
                    m_matched[i] = m_matched[i]
                    f_matched[j] = f_matched[j]
                end
            end
        end
    end
    return m_matched, f_matched
end